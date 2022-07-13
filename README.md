# Dotfiles

Programs and configs for my POSIX environment.

## Additional packages

* <https://github.com/drduh/YubiKey-Guide>
* <https://github.com/jappeace/brightnessctl>

## Misc configuration

```bash
sudo dpkg-reconfigure console-setup
sudo apt install dict-gcide
sudo systemctl enable unattended-upgrades
sudo vim /etc/fstab  # Comment out swap
```

## NVIDIA dedicated graphics

Download the latest driver from <https://www.nvidia.com/>.

1. Run `nvidia-settings`.
2. Enable "Force Full Composition Pipeline".
3. Press "Save to X Configuration File".

## Intel integrated graphics

To prevent crashes:

```bash
MESA_LOADER_DRIVER_OVERRIDE=i965 blender
MESA_LOADER_DRIVER_OVERRIDE=i965 DRI_PRIME=0 godot
```

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

## Encrypting Raspberry Pi

Taken from <https://askubuntu.com/a/1296450/713087>.

> **EDIT**: I misread the original question, but everything still applies. Using `/dev/mmcblk0p2` below is for installing to the microSD card. To install to an external SSD/HD the device will likely be `/dev/sda2`. Use the appropriate device when editing `cmdline.txt`, `crypttab`, and booting for the first time via `(initramfs)`.
> 
> The latest Ubuntu image includes cryptsetup, so you can convert the "writeable"
> (root) partition to LUKS using your desktop PC. I began with the [20.10 64-bit
> Server image](https://ubuntu.com/download/raspberry-pi).
> 
> 1. [Prepare your SD
> card](https://ubuntu.com/tutorials/how-to-install-ubuntu-on-your-raspberry-pi)
> but do not install into the RPi. Keep it on your desktop PC.
>
> 1. Unmount the SD card (/dev/sdc2 is my "writeable" (root) partition - yours may
>    be different).
>
>        sudo umount /dev/sdc2
>
> 1. Check the partition: `sudo e2fsck -f /dev/sdc2`
>
> 1. Shrink the partition: `sudo resize2fs -M /dev/sdc2`
>
> 1. Encrypt the partition (RPi does not have hardware AES support, [Adiantum
>    seems to perform
>    better](https://www.raspberrypi.org/forums/viewtopic.php?f=63&t=252980&p=1543723#p1543753))...
>
>        sudo cryptsetup-reencrypt --new --reduce-device-size=16M --type=luks2 -c xchacha12,aes-adiantum-plain64 -s 256 -h sha512 --use-urandom /dev/sdc2
>
> 1. Decrypt the LUKS partition: `sudo cryptsetup luksOpen /dev/sdc2 rootfs`
>
> 1. Expand the partition: `sudo resize2fs /dev/mapper/rootfs`
>
> 1. Mount the partition: `sudo mkdir mnt; sudo mount /dev/mapper/rootfs mnt;`
>
> 1. Edit etc/crypttab... `sudo vim mnt/etc/crypttab`
>     - Add ```rootfs  /dev/mmcblk0p2	none	luks```
>
> 1. Edit etc/fstab... `sudo vim mnt/etc/fstab`
>     - Change the first line to ```/dev/mapper/rootfs	/	 ext4	defaults,noatime	0 0```
>
> 1. On the system-boot partition, edit `cmdline.txt`...
>     - change `root=LABEL=writable` to `root=/dev/mapper/rootfs`
>     - remove `splash` (so it prompts for the passphrase on boot)
>     - add `cryptdevice=/dev/mmcblk0p2:sdcard` to the end of the line
>
> 1. It should look like this...
>
>        dwc_otg.lpm_enable=0 console=serial0,115200 console=tty1 root=/dev/mapper/rootfs rootfstype=ext4 elevator=deadline rootwait fixrtc quiet cryptdevice=/dev/mmcblk0p2:sdcard
>
> 1. Unmount the microSD card and install into the Raspberry Pi. **It will fail to
>    boot and enter (initramfs)** because initramfs hasn't been updated yet.
>
> 1. Manually decrypt from initramfs: `(initramfs) cryptsetup luksOpen /dev/mmcblk0p2 rootfs`
>
> 1. Continue booting: `(initramfs) exit`
>
> 1. Login (ubuntu/ubuntu) and update initramfs: `sudo update-initramfs -u`
>
> 1. Reboot: `sudo reboot`
> 
> It should reboot, prompt for the passphrase, then start the OS.
