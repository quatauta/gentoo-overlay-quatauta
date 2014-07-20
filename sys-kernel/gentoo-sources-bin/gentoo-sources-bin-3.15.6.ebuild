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
SLOT="${KV}"
KEYWORDS="~amd64"
IUSE="experimental"

DEPEND="sys-kernel/genkernel-next"
RDEPEND="${DEPEND}"

src_compile() {
	CONFIG_ARCH="$(tc-arch-kernel)"
	[ "$(tc-arch)" = "amd64" ] && CONFIG_ARCH="x86_64"
	KERNEL_CONFIG="/etc/kernels/kernel-config-${CONFIG_ARCH}-${KV}"
	CACHE_DIR="${WORKDIR}/cache"
	MODULES_PREFIX="${WORKDIR}/compiled"
	BOOT_DIR="${WORKDIR}/compiled/boot"
	FIRMWARE_DIR="${WORKDIR}/compiled/lib/firmware-${KV}"
	KERNEL_SRC_DIR="${WORKDIR}/compiled/usr/src/linux-${KV}"

	mkdir -p \
		"${BOOT_DIR}" \
		"${CACHE_DIR}" \
		"${FIRMWARE_DIR}" \
		"${KERNEL_SRC_DIR}" \
		"${MODULES_PREFIX}"

	(
		cd "${S}"
		ARCH="$(tc-arch-kernel)"
		O="${KERNEL_SRC_DIR}"
		cp "${KERNEL_CONFIG}" "${O}/.config"
		make ${MAKEOPTS} O="${O}" modules_prepare || die "make modules_prepare failed"
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

	find "${WORKDIR}/compiled" -mindepth 1 -maxdepth 3 -type d -print0 | xargs -0r rmdir >/dev/null 2>&1
}

src_install() {
	cp -a "${WORKDIR}/compiled"/* "${D}"/. || die "Copying kernel, firmware and modules failed"

	elog "Firmware is stored in /lib/firmware-${KV}"
	elog "You may need to make a symlink from ${D}/lib/firmware to use it"
	elog "ln -s /lib/firmware-${KV} /lib/firmware"
}
