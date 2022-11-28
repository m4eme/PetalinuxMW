FILESEXTRAPATHS_prepend := "${THISDIR}/files/zynq/fs-overlay/etc/:"
#S = "${WORKDIR}/mw-fs-overlay"
#S = "${WORKDIR}"
#

#SRCREV = "e5aee22e4be75e75a854ab64503fc80598bc2004"
#SRC_URI = "git://github.com/u-boot/u-boot.git;protocol=https"

SRCREV = "265d7a7ff8a82792344e8fb5c322e8f00d47e6cc"
SRC_URI = "git://github.com/Xilinx/u-boot-xlnx;protocol=https"

SRC_URI += "file://fw_env.config"

do_install_append() {
    install -d ${D}${sysconfdir}
#    install -m 0644 ${WORKDIR}/fw_env.config  ${D}${sysconfdir}/fw_env.config
}
PACKAGE_ARCH = "${MACHINE_ARCH}"
