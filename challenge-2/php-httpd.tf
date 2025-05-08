resource "docker_image" "php-httpd-image" {
  name = "php-httpd:challenge"
  build {
    path = "lamp_stack/php_httpd"
    label = {
      challenge = "second"
    }
  }
}

resource "docker_container" "php-httpd" {
  name     = "webserver"
  image    = dbocker_image.php-httpd-image.id
  hostname = "php-httpd"
  networks_advanced {
    name = docker_network.private_network.id
  }
  ports {
    internal = 80
    external = 80
  }
  labels {
    label = "challenge"
    value = "second"
  }
  volumes {
    container_path = "/var/www/html"
    host_path      = "/root/code/terraform-challenges/challenge2/lamp_stack/website_content/"
  }
}