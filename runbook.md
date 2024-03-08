Runbook for AWS Terraform
Table of Contents
 Introduction
 Autoscaling for EC2
 Configure RDS as a Cluster
 Configure Database Backups
 Configure S3 Versioning
 Configure CloudWatch Metrics and Alerting
 Common Tasks
 Troubleshooting
 Introduction
1 Accessing the Infrastructure
1.1 Bastion Host Access
2 Monitoring
2.1 CloudWatch Metrics
2.2 Logs
3 Scaling
3.1 Autoscaling
4 Backup and Recovery
4.1 RDS MySQL Backups
5 Maintenance
5.1 Software Updates
5.2 Infrastructure Changes
1. Accessing the Infrastructure
1.1 Bastion Host Access
To access the infrastructure securely, follow these steps:
Connect to the Bastion Host:
Use an SSH client to connect to the Bastion Host:
ssh -i <path-to-keyfile> ec2-user@<bastion-host-ip>
Access Other Instances:
From the Bastion Host, connect to other instances within the private subnets:
ssh -i <path-to-keyfile> ec2-user@<private-instance-ip>
2. Monitoring
2.1 CloudWatch Metrics
CloudWatch provides essential metrics for monitoring system health. Access the AWS Management Console and navigate to CloudWatch to view and analyze metrics related to EC2 instances, Load Balancer, and other resources.
Access CloudWatch Metrics:
Navigate to the AWS Management Console.
Select CloudWatch.
Choose Metrics in the CloudWatch dashboard.
Explore and analyze metrics for different resources.
2.2 Logs
CloudWatch Logs store application and access logs. To access logs:
Navigate to CloudWatch Logs:
Navigate to the AWS Management Console.
Select CloudWatch.
Choose Logs in the CloudWatch dashboard.
Select the log group associated with your application or resource.
View and Troubleshoot Logs:
Review logs for troubleshooting and monitoring purposes.
Use insights gained from logs to address issues and optimize performance.
3. Scaling
3.1 Autoscaling
Autoscaling is configured to scale instances based on network traffic. Monitor traffic patterns, and if necessary, adjust the autoscaling configuration.
Access Autoscaling Groups:
Navigate to the AWS Management Console.
Select EC2.
In the EC2 Dashboard, choose Auto Scaling Groups.
Adjust Autoscaling Configuration:
Update the desired capacity or adjust scaling policies based on observed traffic patterns.
4. Backup and Recovery
4.1 RDS MySQL Backups
RDS MySQL is configured for automated backups every 12 hours with a retention period of 7 days. To restore from a backup:
Navigate to RDS Console:
Navigate to the AWS Management Console.
Select RDS.
Restore from Backup:
Choose Databases in the RDS dashboard.
Select the RDS instance.
Go to the Actions dropdown and choose Restore to Point in Time.
5. Maintenance
5.1 Software Updates
Keep the software and operating systems up-to-date to ensure security and performance. Follow these steps:
Connect to Instances:
Connect to instances using the Bastion Host.
Update Packages:
Update packages on EC2 instances:
5.2 Infrastructure Changes
When making changes to the infrastructure, use Terraform to apply updates:
Navigate to Terraform Code Directory:
Navigate to the Terraform code directory.
Apply Changes:
Run the following commands:
create s3 bucket
terraform init
terraform plan
terraform apply