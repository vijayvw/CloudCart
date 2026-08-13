<?php
/**
 * models/Product.php
 * CRUD operations for the "products" table on AWS RDS (MySQL).
 */

namespace KuCL;

use KuCL\Config\Database;
use PDO;

class Product
{
    private PDO $db;

    public function __construct()
    {
        $this->db = Database::getConnection();
    }

    /** CREATE - add a new product */
    public function create(array $data): array
    {
        $sql = "INSERT INTO products (name, description, price, stock_qty, category)
                VALUES (:name, :description, :price, :stock_qty, :category)";

        $stmt = $this->db->prepare($sql);
        $stmt->execute([
            ':name'        => $data['name'],
            ':description' => $data['description'] ?? null,
            ':price'       => $data['price'],
            ':stock_qty'   => $data['stock_qty'] ?? 0,
            ':category'    => $data['category'] ?? null,
        ]);

        $newId = (int) $this->db->lastInsertId();
        return $this->find($newId);
    }

    /** READ - all products (optionally filtered by category) */
    public function all(?string $category = null): array
    {
        if ($category) {
            $stmt = $this->db->prepare("SELECT * FROM products WHERE category = :category ORDER BY id DESC");
            $stmt->execute([':category' => $category]);
        } else {
            $stmt = $this->db->query("SELECT * FROM products ORDER BY id DESC");
        }

        return $stmt->fetchAll();
    }

    /** READ - single product by id */
    public function find(int $id): ?array
    {
        $stmt = $this->db->prepare("SELECT * FROM products WHERE id = :id");
        $stmt->execute([':id' => $id]);
        $row = $stmt->fetch();

        return $row ?: null;
    }

    /** UPDATE - partial update of a product */
    public function update(int $id, array $data): ?array
    {
        if (!$this->find($id)) {
            return null;
        }

        $fields = [];
        $params = [':id' => $id];

        foreach (['name', 'description', 'price', 'stock_qty', 'category'] as $field) {
            if (array_key_exists($field, $data)) {
                $fields[] = "$field = :$field";
                $params[":$field"] = $data[$field];
            }
        }

        if (empty($fields)) {
            return $this->find($id); // nothing to update
        }

        $sql = "UPDATE products SET " . implode(', ', $fields) . " WHERE id = :id";
        $stmt = $this->db->prepare($sql);
        $stmt->execute($params);

        return $this->find($id);
    }

    /** DELETE - remove a product */
    public function delete(int $id): bool
    {
        $stmt = $this->db->prepare("DELETE FROM products WHERE id = :id");
        $stmt->execute([':id' => $id]);

        return $stmt->rowCount() > 0;
    }
}
