# DynamoDB Item Insertion Guide

This guide provides instructions on how to add an item to the DynamoDB table using the AWS CLI. The item represents metadata for a data stream.

## Prerequisites

- AWS CLI installed and configured with access to your AWS account.
- Permissions to access DynamoDB and perform `put-item` operations on the specified table.

## AWS CLI Command

To add an item to the DynamoDB table, use the following AWS CLI command:

```bash
aws dynamodb put-item --table-name talosi-datalake-metadata-dev --item '{
        "stream_id": {"S": "supply_users"},
        "timestamp": {"N": "1695000000"},
        "file_path": {"S": "/supply_users"},
        "file_type": {"S": "csv"},
        "rules": {
            "M": {
                "columns_count": {"N": "13"}
            }
        }
    }'
```
