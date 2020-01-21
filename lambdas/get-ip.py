import boto3
import time

region = 'YOUR_REGION'
instance_id = 'YOUR_INSTANCE_ID'

def lambda_handler(event, context):
    ec2 = boto3.resource('ec2', region_name=region)
    instance = ec2.Instance(instance_id)
    if instance.public_ip_address is None:
        response = "instance down"
    else:
        response = instance.public_ip_address
    
    return {
        "statusCode": 200,
        "body": response
    }