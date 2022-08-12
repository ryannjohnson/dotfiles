# Netplan

Set the default interface as optional and set the nameservers.

```yaml
network:
  ethernets:
    enp3s0:
      dhcp4: true
      optional: true
      nameservers:
              addresses: [1.1.1.1, 1.0.0.1]
  version: 2
```

Alternatively, turn over all control to NetworkManager.

```yaml
# https://askubuntu.com/a/1122769/713087
network:
  version: 2
  renderer: NetworkManager
```
