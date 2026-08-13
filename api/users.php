<?php
/**
 * api/users.php
 * REST-style endpoint for user detail CRUD against DynamoDB (NoSQL).
 *
 * GET    api/users.php                -> list users (scan, demo-scale only)
 * GET    api/users.php?user_id=xyz    -> get single user
 * POST   api/users.php                -> create user (JSON body)
 * PUT    api/users.php?user_id=xyz    -> update user (JSON body)
 * DELETE api/users.php?user_id=xyz    -> delete user
 */

require_once __DIR__ . '/../config/config.php';
require_once __DIR__ . '/../vendor/autoload.php';
require_once __DIR__ . '/helpers.php';

use KuCL\User;

$user   = new User();
$method = $_SERVER['REQUEST_METHOD'];
$userId = $_GET['user_id'] ?? null;

try {
    switch ($method) {
        case 'GET':
            if ($userId) {
                $row = $user->find($userId);
                $row
                    ? respond(true, $row)
                    : respond(false, null, 'User not found', 404);
            } else {
                respond(true, $user->all());
            }
            break;

        case 'POST':
            $data = readJsonBody();
            validateRequired($data, ['name', 'email']);
            $created = $user->create($data);
            respond(true, $created, 'User created', 201);
            break;

        case 'PUT':
            if (!$userId) {
                respond(false, null, 'Missing user_id', 400);
            }
            $data = readJsonBody();
            $updated = $user->update($userId, $data);
            $updated
                ? respond(true, $updated, 'User updated')
                : respond(false, null, 'User not found', 404);
            break;

        case 'DELETE':
            if (!$userId) {
                respond(false, null, 'Missing user_id', 400);
            }
            $deleted = $user->delete($userId);
            $deleted
                ? respond(true, null, 'User deleted')
                : respond(false, null, 'User not found', 404);
            break;

        default:
            respond(false, null, 'Method not allowed', 405);
    }
} catch (\Throwable $e) {
    respond(false, null, 'Server error: ' . $e->getMessage(), 500);
}
