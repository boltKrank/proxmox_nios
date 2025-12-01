#!/opt/homebrew/bin/bash
set -x

HOST="proxmox.local.localdomain"

IMAGE_NAME="nios-9.0.7-53931-516906214e77-2025-07-25-08-33-24-resizable-150G.qcow2"
LOCAL_IMAGE="NIOS_images/$IMAGE_NAME"
REMOTE_IMAGE_PATH="/var/lib/vz/template/qcow2/"

TEMPLATE_NAME="nios-9.0.7-template"
TEMPLATE_ID=9000


#VM Specs
VM_CPU_COUNT=2
VM_MEMORY=2048
#VM_STORAGE


# Create directory if it doesn't exist

sshpass -p "mypassword123" ssh root@$HOST "mkdir -p $REMOTE_IMAGE_PATH"

# Upload image to Proxmox

rsync -avh --progress \
  $LOCAL_IMAGE \
  root@$HOST:$REMOTE_IMAGE_PATH

# Create an empty VM

sshpass -p 'mypassword123' ssh -o StrictHostKeyChecking=no \
  root@$HOST "
  qm create $TEMPLATE_ID \
    --name $TEMPLATE_NAME \
    --memory $VM_MEMORY \
    --cores $VM_CPU_COUNT \
    --net0 virtio,bridge=vmbr0
    
  qm template $TEMPLATE_ID
"

