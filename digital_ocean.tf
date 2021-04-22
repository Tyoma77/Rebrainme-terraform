provider "digitalocean" {
  token = var.token
}


data "digitalocean_ssh_key" "rebrain_key" {
    name = var.key_name
}

resource "digitalocean_ssh_key" "my_key" {
  name = "my key"
  public_key = file(var.pub_key_path)
}

resource "digitalocean_droplet" "first_drop" {
  image = "ubuntu-18-04-x64"
  name = "first-machne"
  region = "LON1"
  size = "s-1vcpu-1gb"
  ssh_keys = [ data.digitalocean_ssh_key.rebrain_key.id, digitalocean_ssh_key.my_key.fingerprint ]
  tags = [ "devops", "toma77_at_ya_ru" ]
}