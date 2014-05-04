# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gwenhywfar/gwenhywfar-4.3.3.ebuild,v 1.6 2013/03/02 23:38:02 hwoarang Exp $

EAPI=4

DESCRIPTION="A multi-platform helper library for other libraries"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
MY_SRC_PKG="01"
MY_SRC_RELEASE="76"
MY_SRC_FILE="01"
MY_P="${PN}-${PV/_beta/beta}"
SRC_URI="http://www.aquamaniac.de/sites/download/download.php?package=${MY_SRC_PKG}&release=${MY_SRC_RELEASE}&file=${MY_SRC_FILE}&dummy=${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc fox gtk qt4"

RDEPEND="dev-libs/libgpg-error
	>=dev-libs/libgcrypt-1.2.0
	dev-libs/openssl:0
	>=net-libs/gnutls-2.0.1
	virtual/libiconv
	virtual/libintl
	fox? ( x11-libs/fox:1.6 )
	gtk? ( >=x11-libs/gtk+-2.17.5:2 )
	qt4? ( dev-qt/qtgui:4 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext
	doc? ( app-doc/doxygen )"

# broken upstream, reported but got no reply
RESTRICT="test"

src_unpack() {
	unpack ${A}
	mv "${MY_P}" "${P}" || die "Can not rename ${MY_P} to ${P}"
}

src_configure() {
	local guis
	use fox && guis="${guis} fox16"
	use gtk && guis="${guis} gtk2"
	use qt4 && guis="${guis} qt4"

	econf \
		--enable-ssl \
		--enable-visibility \
		$(use_enable debug) \
		$(use_enable doc full-doc) \
		--with-guis="${guis}" \
		--with-docpath=/usr/share/doc/${PF}/apidoc
}

src_compile() {
	emake
	use doc && emake srcdoc
}

src_install() {
	emake DESTDIR="${D}" install
	use doc && emake DESTDIR="${D}" install-srcdoc
	dodoc AUTHORS ChangeLog README TODO
	find "${ED}" -name '*.la' -exec rm -f {} +
}
