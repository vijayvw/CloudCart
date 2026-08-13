<?php
/**
 * api/helpers.php
 * Shared helper functions used by all API endpoints.
 */

if (!function_exists('readJsonBody')) {
    function readJsonBody(): array
    {
        $raw = file_get_contents('php://input');
        $data = json_decode($raw, true);
        return is_array($data) ? $data : [];
    }
}

if (!function_exists('validateRequired')) {
    function validateRequired(array $data, array $fields): void
    {
        foreach ($fields as $f) {
            if (!array_key_exists($f, $data) || $data[$f] === '') {
                respond(false, null, "Missing required field: $f", 422);
            }
        }
    }
}

if (!function_exists('respond')) {
    function respond(bool $success, $data = null, ?string $message = null, int $code = 200): void
    {
        http_response_code($code);
        echo json_encode([
            'success' => $success,
            'message' => $message,
            'data'    => $data,
        ]);
        exit;
    }
}
