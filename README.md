# proxmox_nios

Automating deployment of Infoblox NIOS to Proxmox using Terraform

## Proxmox credentials

hostname: proxmox.local.localdomain
username: root
password: mypassword123

NOTE: this is very insecure - using tokens is recommended

## Preparing qcow2 image

I'll be using the image: `nios-9.0.7-53931-516906214e77-2025-07-25-08-33-24-resizable-150G.qcow2` located in the NIOS_images directory

We'll run the script to make this available on the Proxmox server (prepare_nios_template.sh):
