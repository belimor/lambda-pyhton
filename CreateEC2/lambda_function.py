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
    
    status = instance.update()
        while status == 'pending':
            time.sleep(10)
            print('Waiting for the instances...')
            status = instance.update()

    if status == 'running':
        instance.add_tag("Name","tmp")
        instance.add_tag("Action","Stop")
    else:
        print('Instance status: ' + status)
        return None

    return {
        'statusCode': 200,
        'body': json.dumps('This is the end')
    }
