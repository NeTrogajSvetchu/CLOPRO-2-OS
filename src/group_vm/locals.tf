locals {
  ssh-keys = file("/ssh_key/id_ed25519.pub")
  ssh-private-keys = file("/ssh_key/id_ed25519")
}