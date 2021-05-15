import os
import json
import boto3

AMI = os.environ['AMI']
INSTANCE_TYPE = os.environ['INSTANCE_TYPE']
KEY_NAME = os.environ['KEY_NAME']
SUBNET_ID = os.environ['SUBNET_ID']

ec2 = boto3.resource('ec2')

def lambda_handler(event, context):
    instance = ec2.create_instances(
        ImageId         = AMI,
        InstanceType    = INSTANCE_TYPE,
        KeyName         = KEY_NAME,
        SubnetId        = SUBNET_ID,
        MinCount        = 1,
        MaxCount        = 1
    )
    print('====')
    print("New instance created:", instance[0].id)
    print('====')
    print(event)
    print('====')
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
