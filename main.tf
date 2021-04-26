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

resource "random_string" "vps_password" {
  count = length(var.devs)
  length = 16
  special = false
}

resource "digitalocean_droplet" "do_vps" {
  count = length(var.devs)
  image = var.do_server_image
  name = "${element(var.devs, count.index)}"
  region = var.do_server_region
  size = var.do_server_size
  ssh_keys = [ data.digitalocean_ssh_key.rebrain_key.id, digitalocean_ssh_key.my_key.fingerprint ]
  tags = [ var.do_module_tag, var.do_email_tag ]

  provisioner "remote-exec" {
    connection {
      host = self.ipv4_address
      type = var.prov_con_type
      user = var.do_vps_user
      private_key = "${file(var.prv_key_path)}"
    }

    inline = [
      "echo '${var.do_vps_user}:${element(random_string.vps_password.*.result, count.index)}' | sudo  chpasswd",
    ]
  }
}

data "digitalocean_droplet" "do_server" {
  count = length(var.devs)
  name = digitalocean_droplet.do_vps[count.index].name
} 

data "aws_route53_zone" "selected" {
  name = var.aws_route53_zone_name
}

resource "aws_route53_record" "www" {
  count = length(var.devs)
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "${var.aws_route53_record_prefix}-${element(split("-", element(var.devs, count.index)), 0)}.${var.aws_route53_zone_name}"
  type    = var.aws_route53_record_type
  ttl     = var.aws_route53_record_ttl
  records = [element(data.digitalocean_droplet.do_server.*.ipv4_address, count.index)]
}

resource "local_file" "list_of_vps" {
  content = "${templatefile("${path.module}/vps.tpl", {
    ip_adr = local.do_ip_adress
    pwd = local.do_passwd
    dns = local.vps_dns
    }
  )}"
  filename = "${path.module}/vps.txt"
}

