#!/bin/bash

# Mengecek apakah pengguna telah menjalankan skrip dengan hak akses root (sudo)
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root using sudo."
    exit 1
fi

# Mengecek apakah gcc dan make sudah diinstal atau belum
if ! command -v gcc &> /dev/null || ! command -v make &> /dev/null; then
    echo "Installing gcc and make..."
    apt update
    apt install gcc make -y
fi

# Membuat direktori /media/cdrom jika belum ada
echo "Creating /media/cdrom directory..."
mkdir --parents /media/cdrom

# Melakukan mount CD-ROM ke /media/cdrom
echo "Mounting CD-ROM..."
mount /dev/cdrom /media/cdrom

# Menjalankan VBoxLinuxAdditions.run
echo "Running VBoxLinuxAdditions.run..."
/media/cdrom/VBoxLinuxAdditions.run

# Memberi pilihan untuk restart
read -p "Installation is complete. Do you want to restart your computer? (y/n): " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
    echo "Restarting..."
    reboot
else
    echo "You can manually restart your computer later to complete the installation."
fi

