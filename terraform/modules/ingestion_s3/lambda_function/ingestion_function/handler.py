import json
import boto3
import os
import csv

s3 = boto3.client('s3')
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table(os.environ['DYNAMODB_TABLE'])

def lambda_handler(event, context):
    for record in event['Records']:
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key']

        if key.startswith('rejects/'):
            return

        # Extract directory name
        directory = key.split('/')[0]

        # Retrieve metadata from DynamoDB
        response = table.get_item(Key={'stream_id': directory})
        metadata = response.get('Item')

        if not metadata:
            move_to_rejects(bucket, key, "No metadata found for the directory")
            return

        # Check file extension
        if not key.endswith('.csv'):
            move_to_rejects(bucket, key, "Invalid file extension")
            return

        # Check column count
        try:
            column_count = metadata['rules']['columns_count']
            s3_object = s3.get_object(Bucket=bucket, Key=key)
            body = s3_object['Body'].read().decode('utf-8')
            reader = csv.reader(body.splitlines())

            if len(next(reader)) != column_count:
                move_to_rejects(bucket, key, "Column count mismatch")
                return

            # Move file to raw bucket
            copy_to_raw(bucket, key, directory)
            s3.delete_object(Bucket=bucket, Key=key)

        except Exception as e:
            move_to_rejects(bucket, key, f"Error processing file: {str(e)}")
            return

def move_to_rejects(bucket, key, reason):
    print(f"Moving {key} to rejects: {reason}")
    s3.copy_object(
        Bucket=bucket,
        CopySource={'Bucket': bucket, 'Key': key},
        Key=f'rejects/{key}'
    )
    s3.delete_object(Bucket=bucket, Key=key)

def copy_to_raw(bucket, key, directory):
    print(f"Copying {key} to raw bucket")
    s3.copy_object(
        Bucket=os.environ['RAW_BUCKET'],
        CopySource={'Bucket': bucket, 'Key': key},
        Key=f'{directory}/{key.split("/")[-1]}'
    )
