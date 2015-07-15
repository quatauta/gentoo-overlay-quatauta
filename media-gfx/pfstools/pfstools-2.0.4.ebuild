# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils cmake-utils

DESCRIPTION="Reading, writing, manipulating and viewing high-dynamic range (HDR) images and video frames"
HOMEPAGE="http://pfstools.sourceforge.net/"
SRC_URI="mirror://sourceforge/pfstools/pfstools/${PV}/${P}.tgz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug doc gdal imagemagick matlab netpbm octave +openexr opengl qt4 raw +tiff"

DEPEND="
	!media-gfx/pfstmo
	!media-gfx/pfscalibration

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

src_prepare() {
	sed -i -e 's|pfsoutrgbe\.1||' "${S}/src/fileformat/CMakeLists.txt"
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable debug)
		$(cmake-utils_use_enable qt4 qt)
		$(cmake-utils_use_enable imagemagick)
		$(cmake-utils_use_enable octave)
		$(cmake-utils_use_enable openexr)
		$(cmake-utils_use_enable netpbm)
		$(cmake-utils_use_enable tiff)
		$(cmake-utils_use_enable gdal)
		$(cmake-utils_use_enable opengl)
		$(cmake-utils_use_enable matlab)
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install || die "cmake install failed"
	dodoc AUTHORS README TODO doc/faq.txt

	if use doc; then
		dodoc doc/pfs_format_spec.pdf
	fi
}
