FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
FILESEXTRAPATHS_prepend := "${THISDIR}/files/mathworks:"

SRC_URI += "file://system-user.dtsi"

SRC_URI += "file://axistream.dtsi"
SRC_URI += "file://base.dtsi"
SRC_URI += "file://sharedmem_iio.dtsi"
SRC_URI += "file://zynq-adi-mw-axistream-iio-common.dtsi"
SRC_URI += "file://zynq-mw-axilite-common.dtsi"
SRC_URI += "file://zynq-mw-axistream-common.dtsi"
SRC_URI += "file://zynq-mw-axistream-iio-common-64.dtsi"
SRC_URI += "file://zynq-mw-axistream-iio-common.dtsi"
SRC_URI += "file://zynq-mw-can.dtsi"
SRC_URI += "file://zynq-mw-cma.dtsi"
SRC_URI += "file://zynq-mw-common.dtsi"
SRC_URI += "file://zynq-mw-dlhdl-iio-common.dtsi"
SRC_URI += "file://zynq-mw-hdmicam-common.dtsi"
SRC_URI += "file://zynq-mw-imageon-common.dtsi"
SRC_URI += "file://zynq-mw-sharedmem-iio-common.dtsi"
SRC_URI += "file://zynq-mw-sharedmem-iio-plmem.dtsi"
SRC_URI += "file://zynq-mw-video.dtsi"

python () {
    if d.getVar("CONFIG_DISABLE"):
        d.setVarFlag("do_configure", "noexec", "1")
}

export PETALINUX
do_configure_append () {
	script="${PETALINUX}/etc/hsm/scripts/petalinux_hsm_bridge.tcl"
	data=${PETALINUX}/etc/hsm/data/
	eval xsct -sdx -nodisp ${script} -c ${WORKDIR}/config \
	-hdf ${DT_FILES_PATH}/hardware_description.${HDF_EXT} -repo ${S} \
	-data ${data} -sw ${DT_FILES_PATH} -o ${DT_FILES_PATH} -a "soc_mapping"
}
