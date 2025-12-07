terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.6.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "docker" {}

resource "docker_image" "site" {
  name = "onelmelvy/devops-site:latest"
  build {
    context = "../" # dossier racine du projet contenant Dockerfile
  }
}

resource "docker_container" "site" {
  name  = "devops-site-container"
  image = docker_image.site.latest

  ports {
    internal = 80
    external = 8080
  }
}
