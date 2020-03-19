FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
FILESEXTRAPATHS_prepend := "${THISDIR}/files/mathworks:"

SRC_URI += "file://system-user.dtsi"
SRC_URI += "file://axistream.dtsi"
SRC_URI += "file://base.dtsi"
SRC_URI += "file://zynqmp-mw-fpga-bridge-common.dtsi"
SRC_URI += "file://zynqmp-mw-common.dtsi"
SRC_URI += "file://mw-aximm-common.dtsi"
SRC_URI += "file://zynqmp-mw-axistream-iio-common.dtsi"
SRC_URI += "file://zynqmp-mw-cma.dtsi"
SRC_URI += "file://xilinx-mw-axistream-iio-common.dtsi"
SRC_URI += "file://xilinx-mw-axistream-dma.dtsi"
SRC_URI += "file://xilinx-mw-axistream-dma.h"
SRC_URI += "file://adi-mw-axistream-dma.h"
SRC_URI += "file://adi-mw-axistream-dma.dtsi"
SRC_URI += "file://mw-axistream-iio-common.dtsi"
SRC_URI += "file://mw-axistream-iio-common.h"
SRC_URI += "file://0001-Fix-the-misc-clock-frequency-type.patch"
