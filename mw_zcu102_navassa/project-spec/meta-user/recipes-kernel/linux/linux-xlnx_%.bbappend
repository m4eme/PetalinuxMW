SRC_URI += "file://bsp.cfg \
            file://user_2022-12-16-12-31-00.cfg \
            "
KERNEL_FEATURES_append = " bsp.cfg"
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
PV = "5.10-adi_2021_R1+git${SRCPV}"

# override kernel config file
KBUILD_DEFCONFIG_zynq = "zynq_xcomm_adv7511_defconfig"
KBUILD_DEFCONFIG_zynqmp = "adi_zynqmp_defconfig"
KBUILD_DEFCONFIG_microblaze = "adi_mb_defconfig"
# In adi_mb_defconfig, CONFIG_INITRAMFS_SOURCE is enabled by default.
# Since we are in petalinux already, a simpleImage will be build with the proper
# initramfs so that, we don't have to provide an external one...

do_configure_prepend_microblaze() {
	[ -f ${B}/.config ] && sed -i 's,CONFIG_INITRAMFS_SOURCE=.*,,' ${B}/.config
}