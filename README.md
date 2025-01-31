# terraform-aws-wordpres

This script will will launch an ec2 instance and a rds instance in AWS and install wordpress.

Before running terraform, create your own public and priate key file pair file and copy the content to **wordpress.pub** and **wordpress.pem** file inside **keys** folder.

**Usage :**
```
terraform init
terraform apply -var 'db_username=value' -var 'db_password=value' -var 'db_name=value' -var 'wp_title=value' -var 'wp_admin_user=value' -var 'wp_admin_pass=value' -var 'wp_admin_email=value'
```
If you do not set the variables, it will take the default variables from **variables.tf** file.

_Note : Make sure AWS access key and secret key are configured properly and have required permission to create resources in AWS._
