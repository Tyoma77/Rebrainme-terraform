output "do_vps_password" {
  value = ["${random_string.vps_password.*.result}"]
}