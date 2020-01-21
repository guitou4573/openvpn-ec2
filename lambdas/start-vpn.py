import boto3

region = 'YOUR_REGION'
instance_id = 'YOUR_INSTANCE_ID'

def lambda_handler(event, context):
    ec2 = boto3.resource('ec2', region_name=region)
    instance = ec2.Instance(instance_id)
    instance.start()
    return {
        "statusCode": 200,
        "body": "done"
    }