<?php
/**
 * models/User.php
 * CRUD operations for user details stored in DynamoDB (NoSQL).
 * Table: KuCL_Users, partition key: user_id (String)
 */

namespace KuCL;

use KuCL\Config\DynamoClient;
use Aws\DynamoDb\Exception\DynamoDbException;

class User
{
    private $client;
    private $marshaler;
    private string $table;

    public function __construct()
    {
        $this->client    = DynamoClient::getClient();
        $this->marshaler = DynamoClient::getMarshaler();
        $this->table     = DYNAMODB_USERS_TABLE;
    }

    /** CREATE - add a new user record */
    public function create(array $data): array
    {
        $userId = $data['user_id'] ?? $this->generateUuid();

        $item = array_merge($data, [
            'user_id'    => $userId,
            'created_at' => gmdate('Y-m-d\TH:i:s\Z'),
        ]);

        try {
            $this->client->putItem([
                'TableName' => $this->table,
                'Item'      => $this->marshaler->marshalItem($item),
                // Prevent accidentally overwriting an existing user with the same id
                'ConditionExpression' => 'attribute_not_exists(user_id)',
            ]);
        } catch (DynamoDbException $e) {
            throw new \RuntimeException('DynamoDB create failed: ' . $e->getAwsErrorMessage());
        }

        return $item;
    }

    /** READ - single user by id */
    public function find(string $userId): ?array
    {
        try {
            $result = $this->client->getItem([
                'TableName' => $this->table,
                'Key'       => $this->marshaler->marshalItem(['user_id' => $userId]),
            ]);
        } catch (DynamoDbException $e) {
            throw new \RuntimeException('DynamoDB read failed: ' . $e->getAwsErrorMessage());
        }

        if (empty($result['Item'])) {
            return null;
        }

        return $this->marshaler->unmarshalItem($result['Item']);
    }

    /** READ - scan all users (fine for demo/small tables; use Query on larger data) */
    public function all(int $limit = 50): array
    {
        try {
            $result = $this->client->scan([
                'TableName' => $this->table,
                'Limit'     => $limit,
            ]);
        } catch (DynamoDbException $e) {
            throw new \RuntimeException('DynamoDB scan failed: ' . $e->getAwsErrorMessage());
        }

        $users = [];
        foreach ($result['Items'] as $item) {
            $users[] = $this->marshaler->unmarshalItem($item);
        }

        return $users;
    }

    /** UPDATE - partial update of user attributes */
    public function update(string $userId, array $data): ?array
    {
        if (!$this->find($userId)) {
            return null;
        }

        unset($data['user_id']); // never overwrite the key

        if (empty($data)) {
            return $this->find($userId);
        }

        $updateExpr  = [];
        $exprNames   = [];
        $exprValues  = [];
        $i = 0;

        foreach ($data as $key => $value) {
            $i++;
            $placeholder = ":v$i";
            $namePlaceholder = "#k$i";
            $updateExpr[]  = "$namePlaceholder = $placeholder";
            $exprNames[$namePlaceholder] = $key;
            $exprValues[$placeholder] = $value;
        }

        try {
            $this->client->updateItem([
                'TableName' => $this->table,
                'Key'       => $this->marshaler->marshalItem(['user_id' => $userId]),
                'UpdateExpression' => 'SET ' . implode(', ', $updateExpr),
                'ExpressionAttributeNames'  => $exprNames,
                'ExpressionAttributeValues' => $this->marshaler->marshalItem($exprValues),
            ]);
        } catch (DynamoDbException $e) {
            throw new \RuntimeException('DynamoDB update failed: ' . $e->getAwsErrorMessage());
        }

        return $this->find($userId);
    }

    /** DELETE - remove a user record */
    public function delete(string $userId): bool
    {
        if (!$this->find($userId)) {
            return false;
        }

        try {
            $this->client->deleteItem([
                'TableName' => $this->table,
                'Key'       => $this->marshaler->marshalItem(['user_id' => $userId]),
            ]);
        } catch (DynamoDbException $e) {
            throw new \RuntimeException('DynamoDB delete failed: ' . $e->getAwsErrorMessage());
        }

        return true;
    }

    private function generateUuid(): string
    {
        // Simple RFC4122 v4 UUID generator (no external dependency needed)
        $data = random_bytes(16);
        $data[6] = chr(ord($data[6]) & 0x0f | 0x40);
        $data[8] = chr(ord($data[8]) & 0x3f | 0x80);

        return vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex($data), 4));
    }
}
