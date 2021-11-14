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
