data "external" "my_ip" {

  program = [

    "bash",

    "-c",

    "IP=$(curl -4 -s https://checkip.amazonaws.com | tr -d '\\n'); jq -n --arg ip \"$IP\" '{ip: $ip}'"

  ]

}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ssm_parameter" "ubuntu" {
  name = "/aws/service/canonical/ubuntu/server/24.04/stable/current/amd64/hvm/ebs-gp3/ami-id"
}
