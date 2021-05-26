import json
import boto3

def lambda_handler(event, context):

    dynamodb = boto3.resource('dynamodb')

    table = dynamodb.create_table(
        TableName='HelloWorld',
        KeySchema=[
            {
                'AttributeName': 'name',
                'KeyType': 'HASH'  # Partition key
            },
            {
                'AttributeName': 'age',
                'KeyType': 'RANGE'  # Sort key
            }
        ],
        AttributeDefinitions=[
            {
                'AttributeName': 'name',
                'AttributeType': 'S'
            },
            {
                'AttributeName': 'age',
                'AttributeType': 'N'
            },
        ],
        ProvisionedThroughput={
            'ReadCapacityUnits': 5,
            'WriteCapacityUnits': 5
        }

    )

    print('Table status:', table.table_status)
    print('Creating DynamoDB: ', table.name, '...')
    table.meta.client.get_waiter('table_exists').wait(TableName='HelloWorld')
    print('Table status:', dynamodb.Table('HelloWorld').table_status)

    user = {
        "name": "John",
        "age": 33
    }

    #user_data = json.dumps(user)
    user_data = json.load(user)
    print(user_data)

    for user in user_data:
        name = user_data['name']
        age = int(user_data['age'])

        table.put_item(
                Item={
                    'name': name,
                    'age': age,
                }
            )

    return {
        'statusCode': 200,
        'body': json.dumps('This is the end')
    }
