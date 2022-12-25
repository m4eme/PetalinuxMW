FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://platform-top.h"
SRC_URI += "file://mw_xilinx_common.h"
SRC_URI += "file://bsp.cfg"
SRC_URI += "file://mw.cfg"

do_copy_configs () {
 cp ${WORKDIR}/mw_xilinx_common.h ${S}/include/configs/mw_xilinx_common.h
}

do_configure_append () {
        if [ "${U_BOOT_AUTO_CONFIG}" = "1" ]; then
                install ${WORKDIR}/platform-auto.h ${S}/include/configs/
                install ${WORKDIR}/platform-top.h ${S}/include/configs/
        fi
}

do_patch_append() {
    bb.build.exec_func('do_copy_configs', d)
}