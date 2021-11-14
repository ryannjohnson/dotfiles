# Dotfiles

Programs and configs for my POSIX environment.

## Additional packages

* <https://github.com/drduh/YubiKey-Guide>
* <https://github.com/hlissner/doom-emacs>
  * <https://github.com/jethrokuan/org-roam>
* <https://github.com/jappeace/brightnessctl>

## Bluetooth headphones

Get info on bluetooth drivers.

```bash
dmesg | grep -i bluetooth
```

Install pulseaudio package for headphones.

```bash
sudo apt install pulseaudio-module-bluetooth
pulseaudio --k
pulseaudio --start
```

Scan for devices and pair.

```bash
bluetoothctl
[bluetooth]# scan on
[bluetooth]# pair AB:12:CD:34:EF:56
[bluetooth]# exit
```

If `Bluetooth: hci0: Failed to send firmware data (-38)`, remove and add the
btusb linux kernel module.

```bash
sudo modprobe -r btusb
sudo modprobe btusb
```

Sources:
- <https://www.nielsvandermolen.com/bluetooth-headphones-ubuntu/>
- <https://ubuntuforums.org/showthread.php?t=2298368>

## NVIDIA Graphics Card

Download the latest driver from <https://www.nvidia.com/>.

1. Run `nvidia-settings`.
2. Enable "Force Full Composition Pipeline".
3. Press "Save to X Configuration File".

## Misc configuration

```bash
sudo apt remove unattended-upgrades
```
