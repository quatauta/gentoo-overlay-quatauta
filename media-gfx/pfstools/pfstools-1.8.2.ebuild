# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit eutils

DESCRIPTION="A set of programs for reading, writing, manipulating and viewing high-dynamic range (HDR) images and video frames"
HOMEPAGE="http://pfstools.sourceforge.net/"
SRC_URI="mirror://sourceforge/pfstools/pfstools/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug doc gdal imagemagick matlab netpbm octave +openexr opengl +tiff"

DEPEND="
    >=media-gfx/dcraw-8.98-r1
	imagemagick? ( >=media-gfx/imagemagick-6.6.1.2 )
	octave? ( >=sci-mathematics/octave-3.2.4-r1 )
	openexr? ( >=media-libs/openexr-1.6.1 )
	netpbm? ( >=media-libs/netpbm-10.49.00 )
	tiff? ( >=media-libs/tiff-3.9.4 )
	gdal? ( >=sci-libs/gdal-1.6.3-r1 )
	opengl? ( >=virtual/glut-1.0 )
	"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	econf \
		--disable-jpeghdr \
		--disable-qt \
		$(use_enable debug) \
		$(use_enable imagemagick) \
		$(use_enable octave) \
		$(use_enable openexr) \
		$(use_enable netpbm) \
		$(use_enable tiff) \
		$(use_enable gdal) \
		$(use_enable opengl) \
		$(use_enable matlab) \
		|| die "configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README TODO doc/faq.txt

	if use doc; then
		dodoc doc/pfs_format_spec.pdf
	fi
}

pkg_postinst() {
	elog ""
	elog "The pfsview program is not being installed because"
	elog "the required QT3 libraries are not available in"
	elog "Portage."
	elog ""
}

