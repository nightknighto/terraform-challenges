resource "docker_image" "mariadb-image" {
  name = "mariadb:challenge"
  build {
    path = "lamp_stack/custom_db"
    label = {
      challenge = "second"
    }
  }
}

resource "docker_volume" "mariadb_volume" {
  name = "mariadb-volume"
}

resource "docker_container" "mariadb" {
  name     = "db"
  image    = docker_image.mariadb-image.id
  hostname = "db"
  networks_advanced {
    name = docker_network.private_network.id
  }
  ports {
    internal = 3306
    external = 3306
  }
  labels {
    label = "challenge"
    value = "second"
  }
  volumes {
    container_path = "/var/lib/mysql"
    volume_name    = docker_volume.mariadb_volume.name
  }
  env = var.mariadb_env
}