terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.6.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "site" {
  name = "onelmelvy/devops-site:latest"
}

resource "docker_container" "site" {
  name  = "devops-site-container"
  image = docker_image.site.image_id

  ports {
    internal = 80
    external = 8080
  }
}
