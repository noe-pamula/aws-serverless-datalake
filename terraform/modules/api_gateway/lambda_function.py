import boto3
import json
import time

def lambda_handler(event, context):
    athena = boto3.client('athena')
    query = event.get('queryStringParameters', {}).get('query', '')
    # query = "select name from users_table limit 10;"

    if not query:
        return {
            'statusCode': 400,
            'body': json.dumps({'error': 'No SQL query provided.'}),
            'headers': {
                'Content-Type': 'application/json',
            }
        }

    database = 'talosi_datalake'
    output_location = 's3://talosi-datalake-serverless/athena/'

    try:
        # Exécute la requête SQL
        response = athena.start_query_execution(
            QueryString=query,
            QueryExecutionContext={'Database': database},
            ResultConfiguration={'OutputLocation': output_location}
        )

        query_execution_id = response['QueryExecutionId']

        # Attendre que la requête soit complétée
        while True:
            status = athena.get_query_execution(QueryExecutionId=query_execution_id)
            print(str(status))
            state = status['QueryExecution']['Status']['State']

            if state in ['SUCCEEDED', 'FAILED', 'CANCELLED']:
                break

            time.sleep(1)

        if state == 'SUCCEEDED':
            # Récupérer les résultats de la requête
            results = athena.get_query_results(QueryExecutionId=query_execution_id)
            rows = []
            for row in results['ResultSet']['Rows']:
                rows.append([col.get('VarCharValue', '') for col in row['Data']])

            return {
                'statusCode': 200,
                'body': json.dumps(rows),
                'headers': {
                    'Content-Type': 'application/json',
                }
            }
        else:
            return {
                'statusCode': 500,
                'body': json.dumps({'error': 'Query failed or was cancelled.'}),
                'headers': {
                    'Content-Type': 'application/json',
                }
            }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)}),
            'headers': {
                'Content-Type': 'application/json',
            }
        }

if __name__ == '__main__':
    print(lambda_handler({}, {}))