`MBR` Master boot record `1983` The first sector is know as the `MBR` and holds information about the partition of the sectors.
Also contains Code that contains information about the boot loader.

`MBR` makes use of of BIOS.

`GPT` Global unique partition identifier

`GPT` by default makes us of, UEFI

UEFI supports BIOS in legacy mode

---

`GPT` has some protection against corruption. Multiple copies of the partition table are spread around the disk. Minimum risk of damaging certain sector. It can also preform recovery from the other slices spread around the disk.