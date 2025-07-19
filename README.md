# ATLAS (All Things Linux Abridged System)
this is the operating system that runs on the tux keychain
a lot of things were taken from the business card linux project, big credit there https://github.com/thirtythreeforty/businesscard-linux

## todo
- [ ] readd flashdrive support
- [ ] clean up readme
- [ ] add persistent directory in /root/
- [ ] fix micropython REPL crash on syntax errors
- [ ] add more packages
- [ ] get https://linux-sunxi.org/USB_Gadget/Ethernet working

## Building
```
git submodule update --init # update buildroot submodule
```

```
cd buildroot
make BR2_EXTERNAL=$PWD/../ keychain_defconfig # generate the config file
make -j$(nproc --ignore=1) # leaves one core free for the host system, less laggy experience
```

```
./output/host/bin/sunxi-fel -p spiflash-write 0 output/images/spiflash.bin # write the image to the flash drive
```

## info about fel
by default holding the reset button when plugging it in will put it into fel mode
if you already wrote and cant access serial though, use a jumper to short these pins on the flash chip (button may be there in later revisions)
i just use like one of those breadboard jumper wires (the little small ones with a like black plastic thing, but the round ones) and hold them like pincers on the pins while plugging it in
![alt text](image.png)

## license
Subject to the below exceptions, code is released under the GNU General Public License, version 3 or (at your option) any later version.
See also the [Buildroot license notice](https://buildroot.org/downloads/manual/manual.html#legal-info-buildroot) for more nuances about the meaning of this license.

Patches are not covered by this license. Instead, they are covered by the license of the software to which the patches are applied.