terraform {
  required_version = ">= 0.12"
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

terraform {
  cloud {
    organization = "in_nobile"
    hostname     = "app.terraform.io" # Optional; defaults to app.terraform.io

    workspaces {
      name = "tf-nobile"
    }
  }
}
