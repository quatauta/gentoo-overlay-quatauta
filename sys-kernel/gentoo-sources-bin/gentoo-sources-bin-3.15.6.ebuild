# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="8"
K_DEBLOB_AVAILABLE="1"
inherit kernel-2
detect_version
detect_arch

DESCRIPTION="Compiles sys-kernel/gentoo-sources-${PVR} using genkernel with config from /etc/kernels"
HOMEPAGE="http://forums.gentoo.org/viewtopic-t-850109.html"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}"
LICENSE=""
KEYWORDS="~amd64"
IUSE="experimental"

DEPEND="sys-kernel/genkernel-next"
RDEPEND="${DEPEND}"

src_compile() {
	local CONFIG_ARCH="$(tc-arch-kernel)"
	[ "$(tc-arch)" = "amd64" ] && CONFIG_ARCH="x86_64"
	local KERNEL_CONFIG="/etc/kernels/kernel-config-${CONFIG_ARCH}-${KV}"
	local CACHE_DIR="${WORKDIR}/cache"
	local MODULE_PREFIX="${WORKDIR}/compiled"
	local BOOT_DIR="${WORKDIR}/compiled/boot"
	local FIRMWARE_DIR="${WORKDIR}/compiled/lib/firmware-${KV}"
	local KERNEL_SRC_DIR="${WORKDIR}/compiled/usr/src/linux-${KV}"

	mkdir -p \
		"${BOOT_DIR}" \
		"${CACHE_DIR}" \
		"${FIRMWARE_DIR}" \
		"${KERNEL_SRC_DIR}" \
		"${MODULE_PREFIX}"

	(
		ARCH="$(tc-arch-kernel)"
		cd "${S}"
		make ${MAKEOPTS} mrproper
		make ${MAKEOPTS} O="${O}" mrproper
		cp "${KERNEL_CONFIG}" "${KERNEL_SRC_DIR}/.config"
		make ${MAKEOPTS} O="${KERNEL_SRC_DIR}" modules_prepare || die "make modules_prepare failed"
	)

	GK_SHARE="/usr/share/genkernel" \
	MAKEOPTS="${MAKEOPTS}" \
	genkernel \
		--bootdir="${BOOT_DIR}" \
		--cachedir="${CACHE_DIR}" \
		--clean \
		--firmware-dir="${FIRMWARE_DIR}" \
		--install \
		--kernel-config="${KERNEL_CONFIG}" \
		--kerneldir="${S}" \
		--logfile="${WORKDIR}/genkernel.log" \
		--module-prefix="${MODULE_PREFIX}" \
		--mrproper \
		--no-gconfig \
		--no-menuconfig \
		--no-nconfig \
		--no-save-config \
		--no-xconfig \
		--tempdir="${T}" \
		kernel || die "genkernel failed"

	find "${WORKDIR}/compiled" -depth -mindepth 1 \( -type d -empty \) -print0 | xargs -0r rmdir -p ; true
}

src_install() {
	# Avoid file collision with sys-kernel/gentoo-sources
	rm -f "${WORLDIR}/compiled/usr/src/linux-${KV}/Makefile"

	cp -a "${WORKDIR}/compiled"/* "${D}"/. || die "Copying kernel, firmware and modules failed"

	elog "Firmware is stored in /lib/firmware-${KV}"
	elog "You may need to make a symlink from ${D}/lib/firmware to use it"
	elog "ln -s /lib/firmware-${KV} /lib/firmware"
}
