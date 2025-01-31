variable "AWS_REGION" {
    default = "eu-north-1"
}

variable "ami" {
    default = "ami-08eb150f611ca277f"
}

variable "instance_type" {
    default = "t3.micro"
}

variable "db_username" {
    type = string
    default = "root"
    validation {
      error_message = "Invalid username"
      condition = can(regex("^[a-zA-Z0-9@-_]{1,32}$", var.db_username))
    }
}

variable "db_password" {
   type = string
   default = "linux123"
   sensitive = true
   validation {
     error_message = "Password can not contain @"
     condition = !can(regex("@",var.db_password))
   }
   validation {
     error_message = "Password can not contain \""
     condition = !can(regex("\"",var.db_password))
   }
   validation {
     error_message = "Password can not contain /"
     condition = !can(regex("/",var.db_password))
   }
   validation {
     error_message = "Password can not contain space"
     condition = !can(regex(" ",var.db_password))
   }
   validation {
     error_message = "Password can not contain '"
     condition = !can(regex("'",var.db_password))
   }
}

variable "db_name" {
    type = string
    default = "wordpress"
    validation {
      error_message = "Database name is invalid"
      condition = can(regex("^[a-zA-Z0-9$_]{1,64}$",var.db_name))
    }
}

variable "wp_title" {
    type = string
    default = "my blog"
}

variable "wp_admin_user" {
    type = string
    default = "admin"
}

variable "wp_admin_pass" {
    type = string
    default = "linux@123"
    sensitive = true
}

variable "wp_admin_email" {
  type = string
  default = "admin@example.com"
}