variable "do_token" {
    description = "DO token"
    type = "string"
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
