#!/bin/bash -eux

touch /etc/kernel/postinst.d/zz-update-efistub
cat <<-EOF >> /etc/kernel/postinst.d/zz-update-efistub
#!/bin/sh
#
# Copy kernel to EFI partition

mkdir -p /boot/efi/EFI/Debian
cp /vmlinuz /boot/efi/EFI/Debian/
EOF

chmod +x /etc/kernel/postinst.d/zz-update-efistub
cp /etc/kernel/postinst.d/zz-update-efistub /etc/kernel/postrm.d/zz-update-efistub
/etc/kernel/postinst.d/zz-update-efistub

touch /etc/initramfs-tools/conf.d/zz-update-efistub
cat <<-EOF >> /etc/initramfs-tools/conf.d/zz-update-efistub
#!/bin/sh
#
# Copy kernel to EFI partition

#!/bin/sh
mkdir -p /boot/efi/EFI/Debian
cp /initrd.img /boot/efi/EFI/Debian/
EOF

chmod +x /etc/initramfs-tools/conf.d/zz-update-efistub
/etc/initramfs-tools/conf.d/zz-update-efistub

touch /sbin/create_EFI_Boot_Entry.sh
cat <<'EOF' >> /sbin/create_EFI_Boot_Entry.sh
#!/bin/sh
#
# Automatically create an EFI Boot entry.

# First compose the variables used as arguments:
label='Debian (EFI stub)'
loader='\EFI\debian\vmlinuz' # Use single \'s !
initrd='\EFI\debian\initrd.img' # Use single \'s !

# Create kernel args
largs="root=UUID=$(findmnt -kno UUID /) rw quiet rootfstype=$(findmnt -kno FSTYPE /) quiet splash add_efi_memmap initrd=${initrd}"

echo $largs

efibootmgr --create --gpt --disk /dev/vda --label "${label}" --loader "${loader}" --unicode "${largs%* }"
EOF

chmod a+x /sbin/create_EFI_Boot_Entry.sh

/sbin/create_EFI_Boot_Entry.sh

shutdown -r +1 &
