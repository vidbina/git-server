output "ip4_addrs" {
  value = "${zipmap(
    hcloud_server.gits.*.name,
    hcloud_server.gits.*.ipv4_address
  )}"
}

output "ids" {
  value = "${zipmap(
    hcloud_server.gits.*.name,
    hcloud_server.gits.*.id
  )}"
}

output "ssh_keys" {
  value = "${hcloud_server.gits.*.ssh_keys}"
}
