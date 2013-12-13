# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit eutils

DESCRIPTION="Photometric calibration of HDR and LDR cameras"
HOMEPAGE="http://pfstools.sourceforge.net/pfscalibration.html"
SRC_URI="mirror://sourceforge/pfstools/pfscalibration/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug"

DEPEND=">=media-gfx/pfstools-1.8.1"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	econf \
		$(use_enable debug) \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README TODO
}
