terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.6.2"
    }
  }
}

provider "docker" {}

# Image Nginx
resource "docker_image" "nginx" {
  name         = "nginx:alpine"
  keep_locally = false
}

# Conteneur
resource "docker_container" "nginx_server" {
  image = docker_image.nginx.image_id
  name  = "devops-site-con"

  ports {
    internal = 80
    external = 8000
  }

  volumes {
    container_path = "/usr/share/nginx/html/index.html"
    host_path      = "${path.cwd}/../index.html"
    read_only      = true
  }

  must_run = true
}
