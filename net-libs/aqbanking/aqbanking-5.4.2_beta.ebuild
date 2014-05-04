# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/aqbanking/aqbanking-5.0.25.ebuild,v 1.5 2012/12/16 13:54:28 ago Exp $

EAPI=4
inherit eutils

DESCRIPTION="Generic Online Banking Interface"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
MY_SRC_PKG="03"
MY_SRC_RELEASE="114"
MY_SRC_FILE="01"
MY_P="${PN}-${PV/_beta/beta}"
SRC_URI="http://www.aquamaniac.de/sites/download/download.php?package=${MY_SRC_PKG}&release=${MY_SRC_RELEASE}&file=${MY_SRC_FILE}&dummy=${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="chipcard debug doc examples gtk ofx"

RDEPEND=">=app-misc/ktoblzcheck-1.39
	>=dev-libs/gmp-5
	>=sys-libs/gwenhywfar-4.9.0_beta[gtk?]
	virtual/libintl
	ofx? ( >=dev-libs/libofx-0.9.5 )
	chipcard? ( >=sys-libs/libchipcard-5.0.2 )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

MAKEOPTS="${MAKEOPTS} -j1" # 5.0.x fails with -j9 on quadcore

src_unpack() {
	unpack ${A}
	mv "${MY_P}" "${P}" || die "Can not rename ${MY_P} to ${P}"
}

src_configure() {
	local backends="aqhbci aqnone"
	use ofx && backends="${backends} aqofxconnect"

	local mytest
	use gtk && mytest="--enable-gui-tests"

	econf \
		$(use_enable debug) \
		$(use_enable doc full-doc) \
		--with-backends="${backends}" \
		--with-docpath=/usr/share/doc/${PF}/apidoc \
		${mytest}
}

src_install() {
	emake DESTDIR="${D}" install

	rm -rf "${ED}"/usr/share/doc/aq{banking,hbci}

	dodoc AUTHORS ChangeLog NEWS README TODO

	newdoc src/plugins/backends/aqhbci/tools/aqhbci-tool/README \
		README.aqhbci-tool

	if use examples; then
		docinto tutorials
		dodoc tutorials/*.{c,h} tutorials/README
	fi

	prune_libtool_files --all
}
