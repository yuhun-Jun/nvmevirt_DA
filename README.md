# Project Overview

This project is dedicated to research on performance degradation caused by file fragmentation. The codebase is branched from [NVMeVirt](https://github.com/snu-csl/nvmevirt) and extends its capabilities. The primary enhancement allows a page-to-die allocation algorithm designed to ensure that contiguous blocks always land on successive dies, even in the face of file fragmentation or overwrites.

## Modified Files

All changes are annotated with "//66f1" before and after.

### conv_ftl.c, conv_ftl.h

- Modified to allocate dies based on information during writes.

### nvme.h

- Added additional fields to the NVMe Command structure.

### ssd.c, ssd.h

- Added die-specific information to the SSD structure.

---

# Installation

## Linux Kernel Requirement

This modification must run alongside the updated kernel. The kernel can be found [here](https://anonymous.4open.science/r/kernel_5_15_DA-2448).

After building this kernel, you need to set the library location for the built module.

The rest is already configured. Simply run 'make'.

## Reserving Physical Memory

A portion of the main memory should be reserved for the emulated NVMe device's storage. To reserve a chunk of physical memory, add the following option to `GRUB_CMDLINE_LINUX` in `/etc/default/grub` as follows:

`GRUB_CMDLINE_LINUX="memmap=128G\$256G intremap=off"`

This example will reserve 128 GiB of physical memory chunk (out of the total 512 GiB physical memory) starting from the 256 GiB memory offset. You may need to adjust those values depending on the available physical memory size and the desired storage capacity.

After changing the `/etc/default/grub` file, you are required to run the following commands to update `grub` and reboot your system.

`$ sudo update-grub`   
`$ sudo reboot`

### Using

When running, use it as shown below. NVMeVirt uses DRAM to store data, so it is very sensitive to NUMA settings. It is recommended to set the cores in the same location as the memory specified in NUMA.

`$ insmod ./nvmev.ko memmap_start=256G memmap_size=120G cpus=131,132,135,136`

Now the emulated `nvmevirt` device is ready to be used as shown below. The actual device number (`/dev/nvme4`) can vary depending on the number of real NVMe devices in your system.

`$ ls -l /dev/nvme*`

`crw------- 1 root root 241, 4 Sep 27 14:40 /dev/nvme4`   
`brw-rw---- 1 root disk 259, 7 Sep 27 14:40 /dev/nvme4n1`

## License

This project follows the GNU license of the original NVMeVirt project. NVMeVirt is offered under the terms of the GNU General Public License version 2 as published by the Free Software Foundation. More information about this license can be found [here](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html).
