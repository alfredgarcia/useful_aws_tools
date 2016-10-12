#pip install boto3
import boto3

regions = ['us-east-1',
            'us-west-1',
            'us-west-2',
            'eu-west-1',
            'eu-central-1',
            'sa-east-1',
            'ap-southeast-1',
            'ap-southeast-2',
            'ap-northeast-1',
            'ap-northeast-2',
            'ap-south-1']

for i in range(0,len(regions)):
    ec2 = boto3.resource('ec2', region_name=regions[i])
    instances = ec2.instances.filter(Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])
    for instance in instances:
        print instance.id+",", instance.instance_type+",", instance.public_ip_address+",", instance.public_dns_name
