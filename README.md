# ATLAS (All Things Linux Abridged System)
This is the operating system that runs on the tux keychain.

## To-do
- [ ] readd flashdrive support
- [x] clean up readme
- [ ] add persistent directory in /root/
- [ ] fix micropython REPL crash on syntax errors
- [ ] add more packages
- [ ] get https://linux-sunxi.org/USB_Gadget/Ethernet working
- [ ] get heartbeat LED working

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
./output/host/bin/sunxi-fel -p spiflash-write 0 output/images/spiflash.bin # write the image to the flash drive, make sure the keychain is in FEL mode
```

## How to enter FEL mode
by default holding the reset button when plugging it in will put it into fel mode
if you already wrote and cant access serial though, use a jumper to short these pins on the flash chip (button may be there in later revisions)
i just use like one of those breadboard jumper wires (the little small ones with a like black plastic thing, but the round ones) and hold them like pincers on the pins while plugging it in
in newer versions this should just be a button on the back of the keychain
![alt text](image.png)

## Serial
You can connect to the keychain using a serial connection.
After waiting a few seconds for the bootloader to load, you can connect using a serial terminal program.
Personally I use `tio`, minicom has issues with text blinking (might be fixable with some settings).

## license
Subject to the below exceptions, code is released under the GNU General Public License, version 3 or (at your option) any later version.
See also the [Buildroot license notice](https://buildroot.org/downloads/manual/manual.html#legal-info-buildroot) for more nuances about the meaning of this license.

Patches are not covered by this license. Instead, they are covered by the license of the software to which the patches are applied.