data "external" "my_ip" {
  program = [
    "bash",
    "-c",
    "IP=$(curl -4 -fsS https://checkip.amazonaws.com | tr -d '\\r\\n'); printf '{\"ip\":\"%s\"}\\n' \"$IP\""
  ]
}

locals {
  my_ip_cidr = "${data.external.my_ip.result.ip}/32"
}
