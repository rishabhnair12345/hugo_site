terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}
# Define the domain in DigitalOcean
resource "digitalocean_domain" "my_domain" {
  name = "nairdevops.xyz"
}
# Create an A record for www.nairdevops.xyz
resource "digitalocean_record" "www" {
  domain = digitalocean_domain.my_domain.name
  type   = "A"
  name   = "www"
  value  = digitalocean_droplet.my_droplet.ipv4_address
  ttl    = 3600
}
# Create an A record for root domain (nairdevops.xyz)
resource "digitalocean_record" "root" {
  domain = digitalocean_domain.my_domain.name
  type   = "A"
  name   = "@"
  value  = digitalocean_droplet.my_droplet.ipv4_address
  ttl    = 3600
}
provider "digitalocean" {
  token = var.do_token
}

variable "do_token" {}

resource "digitalocean_droplet" "my_droplet" {
  name     = "my-devops-droplet"
  region   = "nyc3"                # Choose your preferred region
  size     = "s-1vcpu-1gb"         # $6/month VM
  image    = "ubuntu-22-04-x64"    # OS Image
  ssh_keys = [var.ssh_fingerprint] # Your SSH key
}
output "droplet_ip" {
  value = digitalocean_droplet.my_droplet.ipv4_address
}

variable "ssh_fingerprint" {}
