# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils linux-mod

DESCRIPTION="Kernel module to collect per process network statistics for atop"
HOMEPAGE="http://www.atoptool.nl/netatop.php"
SRC_URI="http://www.atoptool.nl/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND} >=sys-process/atop-2"

BUILD_TARGETS="all"
BUILD_TARGET_ARCH="${ARCH}"
MODULE_NAMES="netatop(misc:${S}:module)"

pkg_setup() {
	linux-mod_pkg_setup

	BUILD_PARAMS="KERN_DIR=${KV_DIR} KERNOUT=${KV_OUT_DIR}"
}

src_prepare() {
	epatch "${FILESDIR}/${P}.patch"
}

src_install() {
	linux-mod_src_install

	doman "man/netatop.4"
	doman "man/netatopd.8"
	dosbin "daemon/netatopd"
}

pkg_postinst() {
	linux-mod_pkg_postinst
}
