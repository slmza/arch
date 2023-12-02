#!/bin/bash

# Instalar herramientas
pacstrap /mnt base linux linux-firmware base-devel efibootmgr os-prober networkmanager grub gvfs nano netctl wpa_supplicant dialog xf86-input-synaptics udisks2 ntfs-3g bash-completion

# Generar fstab
genfstab -U /mnt >> /mnt/etc/fstab

# Configurar sistema
arch-chroot /mnt << EOF

ln -sf /usr/share/zoneinfo/America/Guayaquil /etc/localtime
hwclock --systohc --utc

# Configurar idioma
# nano /etc/locale.gen  # Buscar //en_US.UTF-8 UTF-8
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen 
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=en" > /etc/vconsole.conf

# Configurar hostname
echo "wolf" > /etc/hostname

# Configurar timesyncd.conf para lightdm
timedatectl set-ntp true


sed -i '/#NTP=/d' /etc/systemd/timesyncd.conf

sed -i 's/#Fallback//' /etc/systemd/timesyncd.conf

echo \"FallbackNTP=0.pool.ntp.org 1.pool.ntp.org 0.fr.pool.ntp.org\" >> /etc/systemd/timesyncd.conf

systemctl enable systemd-timesyncd.service

echo "
127.0.0.1    localhost
::1          localhost
127.0.1.1    wolf.localhost wolf
" >> /etc/hosts

systemctl enable NetworkManager
grub-install --efi-directory=/boot --bootloader-id='Arch Linux' --target=x86_64-efi

### Reconocer partición Windows
echo 'GRUB_DISABLE_OS_PROBER=false' >> /etc/default/grub

grub-mkconfig -o /boot/grub/grub.cfg
os-prober
grub-mkconfig -o /boot/grub/grub.cfg
os-prober
grub-mkconfig -o /boot/grub/grub.cfg

# Crear usuario y agregarlo a grupos
useradd -m adrian
passwd adrian << EOF
admin
admin
EOF

usermod -aG wheel,audio,video,storage adrian

# Instalar sudo
pacman -S sudo

# Instalar DWM
pacman -S dwm

# Configurar permisos para apagar o reiniciar
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers

# Establecer contraseña de root
echo "root:admin" | chpasswd

EOF

# ##
exit
umount -R /mnt
reboot
