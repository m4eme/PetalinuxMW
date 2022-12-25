# Dropbear: allow root logins.
 
SRC_URI += " \ 
	file://dropbear.default \
	"
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
 
# Overwrite the dropbear configuration with my configuration.
do_install_append(){
	install -m 0644 ${WORKDIR}/dropbear.default ${D}${sysconfdir}/default/dropbear
}