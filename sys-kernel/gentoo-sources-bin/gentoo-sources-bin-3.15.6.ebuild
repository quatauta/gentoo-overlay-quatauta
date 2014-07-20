# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Compiles sys-kernel/gentoo-sources-${PVR} using genkernel with config from /etc/kernels"
HOMEPAGE="http://forums.gentoo.org/viewtopic-t-850109.html"
SRC_URI=""

inherit check-reqs

LICENSE=""
SLOT="${PF}"
KEYWORDS="~amd64"
IUSE=""

if [ "${PR}" == "r0" ] ; then
	MY_KERNEL_V="${PV}-gentoo"
else
	MY_KERNEL_V="${PV}-gentoo-${PR}"
fi

DEPEND="
	=sys-kernel/gentoo-sources-${PVR}
	sys-kernel/genkernel-next
"
RDEPEND="${DEPEND}"

CHECKREQS_DISK_BUILD="1G"

pkg_setup() {
	check-reqs_pkg_setup
}

src_unpack() {
	local KERNEL_SOURCES="/usr/src/linux-${MY_KERNEL_V}"
	local KERNEL_CONFIG="/etc/kernels/kernel-config-x86_64-${MY_KERNEL_V}"

	cp -a "${KERNEL_SOURCES}" "${WORKDIR}/${P}" || die "Copying kernel sources from ${KERNEL_SOURCES} failed"
	cp "${KERNEL_CONFIG}" "${T}/config" || die "Copying kernel config from ${KERNEL_CONFIG} failed"
}

src_compile() {
	mkdir -p "${WORKDIR}/cache"
	mkdir -p "${WORKDIR}/compiled/boot"
	mkdir -p "${WORKDIR}/compiled/lib"

	GK_SHARE="/usr/share/genkernel" \
	genkernel \
		--kerneldir="${S}" \
		--kernel-config="${T}/config" \
		--bootdir="${WORKDIR}/compiled/boot" \
		--module-prefix="${WORKDIR}/compiled" \
		--clean \
		--mrproper \
		--install \
		--no-gconfig \
		--no-menuconfig \
		--no-nconfig \
		--no-save-config \
		--no-xconfig \
		--cachedir="${WORKDIR}/cache" \
		--logfile="${WORKDIR}/genkernel.log" \
		--tempdir="${T}" \
		kernel || die "genkernel failed"

	# rename firmware dir so it doesn't clash with other installs
	mv "${WORKDIR}/compiled/lib/firmware" "${WORKDIR}/compiled/lib/firmware-${MY_KERNEL_V}" || die "Renaming firmware dir failed"
 }

 src_install() {
	cp -a "${WORKDIR}/compiled"/* "${D}"/. || die "Copying kernel, firmware and modules failed"

	elog "Firmware is stored in ${D}/lib/firmware-${MY_KERNEL_V}"
	elog "You may need to make a symlink from ${D}/lib/firmware to use it"
	elog "ln -s ${D}/lib/firmware-${MY_KERNEL_V} ${D}/lib/firmware"
 }
