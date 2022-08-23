FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " file://platform-top.h"
SRC_URI += " file://0001-add-support-for-artyz.patch"
SRC_URI += " file://0002-allow-to-read-mac-address-from-SPI-flash.patch"
SRC_URI += " file://0003-add-pynqz1-support.patch"
SRC_URI += " file://0004-add-pynqz2-support.patch"
SRC_URI += " file://ethernet_spi.cfg"

do_configure_append () {
	if [ "${U_BOOT_AUTO_CONFIG}" = "1" ]; then
		install ${WORKDIR}/platform-auto.h ${S}/include/configs/
		install ${WORKDIR}/platform-top.h ${S}/include/configs/
	fi
}

do_configure_append_microblaze () {
	if [ "${U_BOOT_AUTO_CONFIG}" = "1" ]; then
		install -d ${B}/source/board/xilinx/microblaze-generic/
		install ${WORKDIR}/config.mk ${B}/source/board/xilinx/microblaze-generic/
	fi
}
