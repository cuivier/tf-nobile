resource "digitalocean_droplet" "vm_1" {
  image    = "ubuntu-20-04-x64"
  name     = "mateusz-kondzior-vm1"
  size     = "s-1vcpu-1gb"
  region   = var.region
  vpc_uuid = digitalocean_vpc.network1.id
  ssh_keys = [digitalocean_ssh_key.key1.id]
}

resource "digitalocean_vpc" "network1" {
  name     = "mkondzior-vpc"
  ip_range = "10.25.25.0/24"
  region   = var.region
}

resource "digitalocean_ssh_key" "key1" {
  name       = "vm1_sshkey"
  public_key = tls_private_key.test2.public_key_openssh
}

resource "tls_private_key" "test2" {
  algorithm = "ED25519"

}

resource "digitalocean_firewall" "vm1_fw" {
  name = "mkondzior-only-ssh"

  droplet_ids = [digitalocean_droplet.vm_1.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

}

resource "digitalocean_project" "cw3" {
  name        = "cw3"
  description = "cwiczenie nr 3."
  purpose     = "ssh"
  environment = "Development"
  resources   = [digitalocean_droplet.vm_1.urn]
}


output "instance_ip" {
  value = digitalocean_droplet.vm_1.public_ip
}

output "opennsh_key" {
  value = tls_private_key.test2.private_key_openssh
}