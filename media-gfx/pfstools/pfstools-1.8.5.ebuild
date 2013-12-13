# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit eutils autotools

DESCRIPTION="Reading, writing, manipulating and viewing high-dynamic range (HDR) images and video frames"
HOMEPAGE="http://pfstools.sourceforge.net/"
SRC_URI="mirror://sourceforge/pfstools/pfstools/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug doc gdal imagemagick matlab netpbm octave +openexr opengl qt4 raw +tiff"

DEPEND="
qt4? ( || ( x11-libs/qt-gui:4 dev-qt/qtgui:4 ) )
	tiff? ( media-libs/tiff )
	netpbm? ( media-libs/netpbm )
	imagemagick? ( media-gfx/imagemagick )
	openexr? ( media-libs/openexr )
	raw? ( media-gfx/dcraw )
	octave? ( sci-mathematics/octave )
	gdal? ( sci-libs/gdal )
	opengl? ( media-libs/freeglut )
	"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	#There is no moc-qt4 in Gentoo
	sed -i 's/moc-qt4/moc/' configure.ac

	# Rerun autotools
	einfo "Regenerating autotools files..."
	eautoreconf || die "eautoreconf failed"
}

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable qt4 qt) \
		$(use_enable imagemagick) \
		$(use_enable octave) \
		$(use_enable openexr) \
		$(use_enable netpbm) \
		$(use_enable tiff) \
		$(use_enable gdal) \
		$(use_enable opengl) \
		$(use_enable matlab) \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README TODO doc/faq.txt

	if use doc; then
		dodoc doc/pfs_format_spec.pdf
	fi
}
