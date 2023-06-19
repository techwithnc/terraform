// Variable values for Staging-ENV
ec2-type = "t2.micro"
avail_zones = ["ap-southeast-1c", "ap-southeast-1b"]
private_ips = ["172.16.1.101", "172.16.2.102"]
subnet_cidrs = ["172.16.1.0/24", "172.16.2.0/24"]
vpc-block = "172.16.0.0/16"
region = "ap-southeast-1"
env-prefix = "dev"
key-location = "~/.ssh/sshkey01.pub"