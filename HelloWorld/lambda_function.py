import os
import json
import boto

AMI = os.environment['AMI']
INSTANCE_TYPE = os.environment['INSTANCE_TYPE']
KEY_NAME = os.environment['KEY_NAME']
SUBNET_ID = os.environment['SUBNET_ID']

ec2 = botot3.resource('ec2')

def lambda_handler(event, context):
    instance = ec2.create_instance(
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
