import json

def lambda_handler(event, context):
    print('====')
    print('Hello Wolrd')
    print('====')
    
    return {
        'statusCode': 200,
        'body': json.dumps('This is the end')
    }
