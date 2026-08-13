<?php
/**
 * models/Order.php
 * CRUD operations for the "orders" table on AWS RDS (MySQL).
 * user_id here corresponds to the DynamoDB KuCL_Users.user_id (string).
 */

namespace KuCL;

use KuCL\Config\Database;
use PDO;

class Order
{
    private PDO $db;

    public function __construct()
    {
        $this->db = Database::getConnection();
    }

    /** CREATE - place a new order (also decrements product stock) */
    public function create(array $data): array
    {
        $productModel = new Product();
        $product = $productModel->find((int) $data['product_id']);

        if (!$product) {
            throw new \InvalidArgumentException('Product not found');
        }
        if ($product['stock_qty'] < $data['quantity']) {
            throw new \RuntimeException('Insufficient stock');
        }

        $totalPrice = $product['price'] * $data['quantity'];

        $this->db->beginTransaction();
        try {
            $stmt = $this->db->prepare(
                "INSERT INTO orders (user_id, product_id, quantity, total_price, status)
                 VALUES (:user_id, :product_id, :quantity, :total_price, 'PENDING')"
            );
            $stmt->execute([
                ':user_id'     => $data['user_id'],
                ':product_id'  => $data['product_id'],
                ':quantity'    => $data['quantity'],
                ':total_price' => $totalPrice,
            ]);
            $orderId = (int) $this->db->lastInsertId();

            $productModel->update($product['id'], [
                'stock_qty' => $product['stock_qty'] - $data['quantity'],
            ]);

            $this->db->commit();
        } catch (\Throwable $e) {
            $this->db->rollBack();
            throw $e;
        }

        return $this->find($orderId);
    }

    /** READ - all orders, optionally filtered by user */
    public function all(?string $userId = null): array
    {
        if ($userId) {
            $stmt = $this->db->prepare(
                "SELECT o.*, p.name AS product_name FROM orders o
                 JOIN products p ON p.id = o.product_id
                 WHERE o.user_id = :user_id ORDER BY o.id DESC"
            );
            $stmt->execute([':user_id' => $userId]);
        } else {
            $stmt = $this->db->query(
                "SELECT o.*, p.name AS product_name FROM orders o
                 JOIN products p ON p.id = o.product_id
                 ORDER BY o.id DESC"
            );
        }

        return $stmt->fetchAll();
    }

    /** READ - single order */
    public function find(int $id): ?array
    {
        $stmt = $this->db->prepare(
            "SELECT o.*, p.name AS product_name FROM orders o
             JOIN products p ON p.id = o.product_id
             WHERE o.id = :id"
        );
        $stmt->execute([':id' => $id]);
        $row = $stmt->fetch();

        return $row ?: null;
    }

    /** UPDATE - typically used to change order status */
    public function update(int $id, array $data): ?array
    {
        if (!$this->find($id)) {
            return null;
        }

        $fields = [];
        $params = [':id' => $id];

        foreach (['status', 'quantity'] as $field) {
            if (array_key_exists($field, $data)) {
                $fields[] = "$field = :$field";
                $params[":$field"] = $data[$field];
            }
        }

        if (empty($fields)) {
            return $this->find($id);
        }

        $sql = "UPDATE orders SET " . implode(', ', $fields) . " WHERE id = :id";
        $stmt = $this->db->prepare($sql);
        $stmt->execute($params);

        return $this->find($id);
    }

    /** DELETE - cancel/remove an order */
    public function delete(int $id): bool
    {
        $stmt = $this->db->prepare("DELETE FROM orders WHERE id = :id");
        $stmt->execute([':id' => $id]);

        return $stmt->rowCount() > 0;
    }
}
