<?php
/**
 * config/config.php
 * Loads environment variables (.env) and exposes app-wide constants.
 */

require_once __DIR__ . '/../vendor/autoload.php';

use Dotenv\Dotenv;

// Load .env file from project root (if present)
if (file_exists(__DIR__ . '/../.env')) {
    $dotenv = Dotenv::createImmutable(__DIR__ . '/..');
    $dotenv->load();
}

// ---- AWS ----
define('AWS_REGION', $_ENV['AWS_REGION'] ?? 'ap-south-1');
define('AWS_ACCESS_KEY_ID', $_ENV['AWS_ACCESS_KEY_ID'] ?? '');
define('AWS_SECRET_ACCESS_KEY', $_ENV['AWS_SECRET_ACCESS_KEY'] ?? '');

// ---- RDS (MySQL) ----
define('RDS_HOST', $_ENV['RDS_HOST'] ?? '127.0.0.1');
define('RDS_PORT', $_ENV['RDS_PORT'] ?? '3306');
define('RDS_DB_NAME', $_ENV['RDS_DB_NAME'] ?? 'kucl_mini_project');
define('RDS_USER', $_ENV['RDS_USER'] ?? 'root');
define('RDS_PASSWORD', $_ENV['RDS_PASSWORD'] ?? '');

// ---- DynamoDB ----
define('DYNAMODB_USERS_TABLE', $_ENV['DYNAMODB_USERS_TABLE'] ?? 'KuCL_Users');
define('DYNAMODB_ENDPOINT', $_ENV['DYNAMODB_ENDPOINT'] ?? ''); // leave blank for real AWS, set for local DynamoDB

// ---- App ----
define('APP_NAME', 'KuCL Mini Project');
header('Content-Type: application/json; charset=UTF-8');

// Simple error reporting toggle - turn off in production
error_reporting(E_ALL);
ini_set('display_errors', '0'); // never leak PHP errors to API responses
