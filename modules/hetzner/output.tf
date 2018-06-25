output "ip4_addrs" {
  value = "${zipmap(
    hcloud_server.gitolite.*.name,
    hcloud_server.gitolite.*.ipv4_address
  )}"
}

output "ids" {
  value = "${zipmap(
    hcloud_server.gitolite.*.name,
    hcloud_server.gitolite.*.id
  )}"
}

output "ssh_keys" {
  value = "${hcloud_server.gitolite.*.ssh_keys}"
}
