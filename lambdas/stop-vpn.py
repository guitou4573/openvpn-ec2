import boto3
region = 'YOUR_REGION'
instances = ['YOUR_INSTANCE_ID']

def lambda_handler(event, context):
    ec2 = boto3.client('ec2', region_name=region)
    ec2.stop_instances(InstanceIds=instances)
    return {
        "statusCode": 200,
        "body": 'stopped your instances: ' + str(instances)
    }