<?php
/**
 * api/products.php
 * REST-style endpoint for product CRUD against AWS RDS.
 *
 * GET    api/products.php            -> list all products
 * GET    api/products.php?id=1       -> get single product
 * POST   api/products.php            -> create product (JSON body)
 * PUT    api/products.php?id=1       -> update product (JSON body)
 * DELETE api/products.php?id=1       -> delete product
 */

require_once __DIR__ . '/../config/config.php';
require_once __DIR__ . '/../vendor/autoload.php';
require_once __DIR__ . '/helpers.php';

use KuCL\Product;

$product = new Product();
$method  = $_SERVER['REQUEST_METHOD'];
$id      = isset($_GET['id']) ? (int) $_GET['id'] : null;

try {
    switch ($method) {
        case 'GET':
            if ($id) {
                $row = $product->find($id);
                $row
                    ? respond(true, $row)
                    : respond(false, null, 'Product not found', 404);
            } else {
                $category = $_GET['category'] ?? null;
                respond(true, $product->all($category));
            }
            break;

        case 'POST':
            $data = readJsonBody();
            validateRequired($data, ['name', 'price']);
            $created = $product->create($data);
            respond(true, $created, 'Product created', 201);
            break;

        case 'PUT':
            if (!$id) {
                respond(false, null, 'Missing product id', 400);
            }
            $data = readJsonBody();
            $updated = $product->update($id, $data);
            $updated
                ? respond(true, $updated, 'Product updated')
                : respond(false, null, 'Product not found', 404);
            break;

        case 'DELETE':
            if (!$id) {
                respond(false, null, 'Missing product id', 400);
            }
            $deleted = $product->delete($id);
            $deleted
                ? respond(true, null, 'Product deleted')
                : respond(false, null, 'Product not found', 404);
            break;

        default:
            respond(false, null, 'Method not allowed', 405);
    }
} catch (\Throwable $e) {
    respond(false, null, 'Server error: ' . $e->getMessage(), 500);
}


