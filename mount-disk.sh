
#!/bin/bash

# Partition the drive /dev/nvme0n2
sudo fdisk /dev/nvme0n2 <<EOF
n
p
p
w
EOF

# Format the partition with ext4
sudo mkfs -t ext4 /dev/nvme0n2

# Create the mount point
sudo mkdir /mnt/uploadDataDisk1

# Mount the disk
sudo mount /dev/nvme0n2 /mnt/uploadDataDisk1

# Get the UUID of the disk
UUID=$(blkid -s UUID -o value /dev/nvme0n2)

# Add the disk to /etc/fstab for auto-mounting
echo "UUID=${UUID} /mnt/uploadDataDisk1 ext4 defaults,nofail 1 2" | sudo tee -a /etc/fstab

# Refresh mount points
sudo mount -a
