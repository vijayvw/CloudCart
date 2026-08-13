<?php
/**
 * api/orders.php
 * REST-style endpoint for order CRUD against AWS RDS.
 *
 * GET    api/orders.php                 -> list all orders
 * GET    api/orders.php?id=1            -> get single order
 * GET    api/orders.php?user_id=xyz     -> list orders for a user
 * POST   api/orders.php                 -> place order (JSON: user_id, product_id, quantity)
 * PUT    api/orders.php?id=1            -> update order (e.g. status)
 * DELETE api/orders.php?id=1            -> cancel/delete order
 */

require_once __DIR__ . '/../config/config.php';
require_once __DIR__ . '/../vendor/autoload.php';
require_once __DIR__ . '/helpers.php';

use KuCL\Order;

$order  = new Order();
$method = $_SERVER['REQUEST_METHOD'];
$id     = isset($_GET['id']) ? (int) $_GET['id'] : null;

try {
    switch ($method) {
        case 'GET':
            if ($id) {
                $row = $order->find($id);
                $row
                    ? respond(true, $row)
                    : respond(false, null, 'Order not found', 404);
            } else {
                $userId = $_GET['user_id'] ?? null;
                respond(true, $order->all($userId));
            }
            break;

        case 'POST':
            $data = readJsonBody();
            validateRequired($data, ['user_id', 'product_id', 'quantity']);
            $created = $order->create($data);
            respond(true, $created, 'Order placed', 201);
            break;

        case 'PUT':
            if (!$id) {
                respond(false, null, 'Missing order id', 400);
            }
            $data = readJsonBody();
            $updated = $order->update($id, $data);
            $updated
                ? respond(true, $updated, 'Order updated')
                : respond(false, null, 'Order not found', 404);
            break;

        case 'DELETE':
            if (!$id) {
                respond(false, null, 'Missing order id', 400);
            }
            $deleted = $order->delete($id);
            $deleted
                ? respond(true, null, 'Order deleted')
                : respond(false, null, 'Order not found', 404);
            break;

        default:
            respond(false, null, 'Method not allowed', 405);
    }
} catch (\Throwable $e) {
    respond(false, null, 'Server error: ' . $e->getMessage(), 500);
}
