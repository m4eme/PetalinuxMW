# fstab - mount /dev/mmcblck0p1 on /mnt
 
SRC_URI += " \ 
	file://fstab \
	"
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

do_install_append(){
    install -m 0644 ${WORKDIR}/fstab ${D}${sysconfdir}/fstab
}