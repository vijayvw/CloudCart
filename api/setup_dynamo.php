<?php
/**
 * api/setup_dynamo.php
 * Run ONCE (CLI: php api/setup_dynamo.php) to create the KuCL_Users
 * DynamoDB table if it doesn't already exist. Alternative to the
 * AWS CLI command shown in sql/dynamodb_setup.md.
 */

require_once __DIR__ . '/../config/config.php';
require_once __DIR__ . '/../vendor/autoload.php';

use KuCL\Config\DynamoClient;
use Aws\DynamoDb\Exception\DynamoDbException;

$client = DynamoClient::getClient();

try {
    $client->describeTable(['TableName' => DYNAMODB_USERS_TABLE]);
    echo "Table '" . DYNAMODB_USERS_TABLE . "' already exists.\n";
    exit;
} catch (DynamoDbException $e) {
    if ($e->getAwsErrorCode() !== 'ResourceNotFoundException') {
        echo "Error checking table: " . $e->getAwsErrorMessage() . "\n";
        exit(1);
    }
}

try {
    $client->createTable([
        'TableName' => DYNAMODB_USERS_TABLE,
        'AttributeDefinitions' => [
            ['AttributeName' => 'user_id', 'AttributeType' => 'S'],
        ],
        'KeySchema' => [
            ['AttributeName' => 'user_id', 'KeyType' => 'HASH'],
        ],
        'BillingMode' => 'PAY_PER_REQUEST',
    ]);

    echo "Creating table '" . DYNAMODB_USERS_TABLE . "'... waiting for it to become active.\n";
    $client->waitUntil('TableExists', ['TableName' => DYNAMODB_USERS_TABLE]);
    echo "Table is ready.\n";
} catch (DynamoDbException $e) {
    echo "Failed to create table: " . $e->getAwsErrorMessage() . "\n";
    exit(1);
}
