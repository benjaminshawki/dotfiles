This document is a work in progress. It is intended to be a guide for setting up a Proxmox Virtual Environment (PVE) server. This document will be updated as we learn more about the system and the requirements for Hemiron.

# Proxmox Reading the friendly manual notes

## Useful links
[Guide document](https://pve.proxmox.com/pve-docs/pve-admin-guide.html)
[Wiki](https://pve.proxmox.com/wiki/)

# Documentatie todo
- Subscription https://www.proxmox.com/en/proxmox-virtual-environment/pricing
- Installatie proces

# Installing notes

## Proxmox Virtual Environment (PVE)

Select the target Harddisk

<img src="https://getlabsdone.com/wp-content/uploads/2023/05/image-55-1024x881.png.webp"/>

## Location and Time Zone selection
Nothing interesing here
- Country: Netherlands
- Timezone: Amsterdam
- Keybaord layout: U.S. English

## Admin password and email
<img src="https://getlabsdone.com/wp-content/uploads/2023/05/image-57-1024x881.png.webp"/>

- We need an email adres where the server will send important alert to (such as backup failures, high availability events)
- Admin password

## Configure hostname and ip
? What should we be using here?

## Summary
Create a picture after the configuration is done


# Post install

## Users
Add additional users to the system, currently only root is configured with the password we set during the installation

# Storage

## What of the following storage types should we use for hemiron?
We currently support the following Network storage types:
- LVM Group (network backing with iSCSI targets)
- iSCSI target
- NFS Share
- CIFS Share
- Ceph RBD
- Directly use iSCSI LUNs
- GlusterFS

Local storage types supported are:
- LVM Group (local backing devices like block devices, FC devices, DRBD, etc.)
- Directory (storage on existing filesystem)
- ZFS

# Networking
default bridged network model
- ?VLAN

# Hyperconverged Infrastructure (HCI)

## Storage

Decide what storage solution to use for the HCI. For the total list of storage solutions https://pve.proxmox.com/pve-docs/pve-admin-guide.html#chapter_storage


### Ceph

A both self-healing and self-managing shared, reliable and highly scalable storage system. [Checkout how to manage Ceph services on Proxmox VE nodes](https://pve.proxmox.com/pve-docs/pve-admin-guide.html#chapter_pveceph)

### ZFS

A combined file system and logical volume manager with extensive protection against data corruption, various RAID modes, fast and cheap snapshots - among other features. [Find out how to leverage the power of ZFS on Proxmox VE nodes.](https://pve.proxmox.com/pve-docs/pve-admin-guide.html#chapter_zfs)

# System requirements

## Ceph, ZFS, and local storage
Note that both Ceph and ZFS have aditional requirements of ~1GB of RAM per TB of storage.

OS storage: Use a hardware RAID with battery protected write cache (“BBU”) or non-RAID with ZFS (optional SSD for ZIL).

## VM storage
For local storage, use either a hardware RAID with battery backed write cache (BBU) or non-RAID for ZFS and Ceph. Neither ZFS nor Ceph are compatible with a hardware RAID controller.

Shared and distributed storage is possible.

SSDs with Power-Loss-Protection (PLP) are recommended for good performance. Using consumer SSDs is discouraged.

