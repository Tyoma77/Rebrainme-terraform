provider "digitalocean" {
  token = var.do_token
}

provider "aws" {
    region = var.aws_region
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key  
}


data "digitalocean_ssh_key" "rebrain_key" {
    name = var.key_name
}

resource "digitalocean_ssh_key" "my_key" {
  name = "my key"
  public_key = file(var.pub_key_path)
}

resource "digitalocean_droplet" "first_drop" {
  image = var.do_server_image
  name = var.do_server_name
  region = var.do_server_region
  size = var.do_server_size
  ssh_keys = [ data.digitalocean_ssh_key.rebrain_key.id, digitalocean_ssh_key.my_key.fingerprint ]
  tags = [ var.do_module_tag, var.do_email_tag ]
}

data "digitalocean_droplet" "do_server" {
  name = digitalocean_droplet.first_drop.name
} 

data "aws_route53_zone" "selected" {
  name = var.aws_route53_zone_name
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = var.aws_route53_record_name
  type    = var.aws_route53_record_type
  ttl     = var.aws_route53_record_ttl
  records = [local.do_ip_adress]
}
