<?php
/**
 * config/DynamoClient.php
 * Singleton wrapper around the AWS DynamoDB SDK client.
 */

namespace KuCL\Config;

use Aws\DynamoDb\DynamoDbClient;
use Aws\DynamoDb\Marshaler;

class DynamoClient
{
    private static ?DynamoDbClient $client = null;
    private static ?Marshaler $marshaler = null;

    public static function getClient(): DynamoDbClient
    {
        if (self::$client === null) {
            $args = [
                'region'  => AWS_REGION,
                'version' => 'latest',
            ];

            // Explicit keys (optional). If omitted, SDK falls back to
            // IAM role / instance profile / default credential chain - recommended for EC2/ECS.
            if (AWS_ACCESS_KEY_ID && AWS_SECRET_ACCESS_KEY) {
                $args['credentials'] = [
                    'key'    => AWS_ACCESS_KEY_ID,
                    'secret' => AWS_SECRET_ACCESS_KEY,
                ];
            }

            // Allows pointing at DynamoDB Local for offline dev/testing
            if (DYNAMODB_ENDPOINT) {
                $args['endpoint'] = DYNAMODB_ENDPOINT;
            }

            self::$client = new DynamoDbClient($args);
        }

        return self::$client;
    }

    public static function getMarshaler(): Marshaler
    {
        if (self::$marshaler === null) {
            self::$marshaler = new Marshaler();
        }

        return self::$marshaler;
    }
}
