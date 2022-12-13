FILESEXTRAPATHS_prepend := "${THISDIR}/files/zynqmp/fs-overlay/etc/:"

SRC_URI += "file://fstab"
#SRC_URI += "file://fw_env.config"

do_install_append() {
    install -d ${D}${sysconfdir}
  #  install -m 0644 ${WORKDIR}/fw_env.config  ${D}${sysconfdir}/fw_env.config
    install -m 0644 ${WORKDIR}/fstab  ${D}${sysconfdir}/fstab
}

FILES_${PN} += " /etc/fstab "
PACKAGE_ARCH = "${MACHINE_ARCH}"
