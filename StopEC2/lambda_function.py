import boto3

regions = ['us-west-2','us-west-1']

def lambda_handler(event, context):
    for region in regions:
        print(region)
        ec2 = boto3.resource('ec2', region_name=region)
        instances = ec2.instances.filter(
            Filters=[
                {
                    'Name': 'tag:Action',
                    'Values': ['Stop'],
                }
            ]
        )
        for instance in instances:
                instance.stop()
                print('Stopped instance: ', instance.id)
