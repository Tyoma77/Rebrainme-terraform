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

variable "do_server_name" {
    description = "Name of the DO server"
    default = "first-machine"
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