<?php
/**
 * config/Database.php
 * Singleton PDO connection to the AWS RDS MySQL instance.
 */

namespace KuCL\Config;

use PDO;
use PDOException;

class Database
{
    private static ?PDO $connection = null;

    public static function getConnection(): PDO
    {
        if (self::$connection === null) {
            $dsn = sprintf(
                'mysql:host=%s;port=%s;dbname=%s;charset=utf8mb4',
                RDS_HOST,
                RDS_PORT,
                RDS_DB_NAME
            );

            try {
                self::$connection = new PDO($dsn, RDS_USER, RDS_PASSWORD, [
                    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                    PDO::ATTR_EMULATE_PREPARES   => false,
                    // For RDS with SSL enforced, uncomment and point to the AWS CA bundle:
                    // PDO::MYSQL_ATTR_SSL_CA => __DIR__ . '/certs/rds-combined-ca-bundle.pem',
                ]);
            } catch (PDOException $e) {
                http_response_code(500);
                echo json_encode([
                    'success' => false,
                    'message' => 'RDS connection failed: ' . $e->getMessage(),
                ]);
                exit;
            }
        }

        return self::$connection;
    }
}
