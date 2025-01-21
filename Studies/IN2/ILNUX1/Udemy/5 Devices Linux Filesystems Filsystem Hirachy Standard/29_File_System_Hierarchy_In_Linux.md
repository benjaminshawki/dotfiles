<h2>File System Hierarchy In Linux</h2>
Once Linux is installed on a system, there is a list of directories that remains more or less the same no matter which distribution you are working on. Following these standards to put files, make it easier for Administrators to identify and locate files. Current File Hierarchy structure was standardized in 2004 and all major distribution follow it. Lets have a look at these directories now and their major functionalities:

`/`    This is the root path of the system. Every other directory is branched from this root.

`/root`    Home Directory for root user.

`/proc`    A virtual filesystem that provides processes and kernel related information as files.

`/var`    Mostly holds the logs, spool files and temporary email files.

`/tmp`    Temporary storage that system automatically uses. It gets cleared upon reboot.

`/boot`    Holds the boot information, including bootloader files like kernel & initrd

`/dev`   In Linux devices are listed as files. This directory holds listing of devices like /dev/sda, /dev/sdb etc.

`/etc`   This directory holds the configuration scripts for most of the programs.

`/lib`    Holds the shared libraries needed to run the core level system programs. For example programs that reside in /bin directory.

`/home`    User files are stored in here. By default useradd command creates a home directory in this folder e.g., /home/ahmad.

`/bin`    Holds system binaries especially for single user mode

`/sbin`    Essential System binary files but require superuser (root) privileges

`/usr/bin`    General system wide binaries

`/usr/sbin`    General system wide binaries that require superuser privileges

`/usr/lib`    Shared libraries for /usr binaries.

`/usr/local`    Holds the sources and binaries of those programs that users compile themselves

`/media`    Temporary storage is mounted in this directory