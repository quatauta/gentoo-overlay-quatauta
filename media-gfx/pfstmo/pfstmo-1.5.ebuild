# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit eutils

DESCRIPTION="Implementation of tone mapping operators for PFStools"
HOMEPAGE="http://pfstools.sourceforge.net/pfstmo.html"
SRC_URI="mirror://sourceforge/pfstools/pfstmo/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug fftw"

DEPEND="
	>=media-gfx/pfstools-1.8.2
	>=sci-libs/gsl-1.14
	fftw? ( sci-libs/fftw:3.0 )
	"

RDEPEND="${DEPEND}"

src_configure() {
	econf \
		$(use_enable debug) \
		|| die "econf configure failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README TODO
}
