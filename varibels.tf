variable "do_token" {
    description = "DO token"
    type = string
}

variable "key_name" {
    description = "Rebrrain SSH public key name"
    default = "REBRAIN.SSH.PUB.KEY"
    type = string
}

variable "pub_key_path" {
    description = "Path to my pulic key"
    default = "D:/terraform_digitalocean/terraform.pub"
    type = string
}

variable "do_server_image" {
    description = "Image name of DO server"
    default = "ubuntu-18-04-x64"
    type = string
}

variable "do_server_region" {
    description = "Region of DO server"
    default = "LON1"
    type = string
}

variable "do_server_size" {
    description = "Size of DO server"
    default = "s-1vcpu-1gb"
    type = string
}

variable "do_module_tag" {
    description = "Tag module for DO server"
    default = "devops"
    type = string
}

variable "do_email_tag" {
    description = "Tag e-mail for DO server"
    default = "tyoma77_at_ya_ru"
    type = string
}

variable "aws_access_key" {
    description = "AWS access key"
    type = string
}

variable "aws_secret_key" {
    description = "AWS secret key"
    type = string
}

variable "aws_region" {
    description = "AWS region"
    default = "eu-west-2"
    type = string
}

variable "aws_route53_record_prefix" {
    description = "AWS route53 record prefix"
    default = "artem-vingradov"
    type = string
}

variable "aws_route53_record_type" {
    description = "AWS route53 record type"
    default = "NS"
    type = string
}

variable "aws_route53_record_ttl" {
    description = "AWS route53 record ttl"
    default = 300
    type = number
}
variable "aws_route53_zone_name" {
    description = "AWS route53 zone name"
    default = "devops.rebrain.srwx.net"
    type = string
}

locals {
   do_ip_adress = data.digitalocean_droplet.do_server.*.ipv4_address
   do_passwd = random_string.vps_password.*.result
   vps_dns = aws_route53_record.www.*.name
}

variable "do_vps_passwd" {
    description = "DO vps root password"
    type = string
}

variable "do_vps_user" {
    description = "DO vps default user"
    default = "root"
    type = string
}

variable "prov_con_type" {
    description = "Provisioner connection type"
    default = "ssh"
    type = string
}

variable "prv_key_path" {
    description = "Path to my pivate key"
    default = "D:/terraform_digitalocean/key/id_rsa"
    type = string
}

variable "devs" {
    description = "List of the virtual machines"
    type = list
    default = ["lb-username", "app1-username", "app2-username"]
}