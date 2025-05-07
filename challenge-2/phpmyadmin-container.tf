resource "docker_container" "phpmyadmin" {
  name = "db_dashboard"
  image = "phpmyadmin/phpmyadmin"
  hostname = "phpmyadmin"
  networks_advanced {
    name = "my_network"
  }
  ports {
    internal = 80
    external = 8081
  }
  labels {
    label = "challenge"
    value = "second"
  }
  links = [
    "db"
  ]
  depends_on = [ docker_container.mariadb ]
}