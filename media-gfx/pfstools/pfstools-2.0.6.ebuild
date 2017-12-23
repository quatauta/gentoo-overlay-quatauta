# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils cmake-utils

DESCRIPTION="Manipulating and viewing high-dynamic range (HDR) images and video frames"
HOMEPAGE="http://pfstools.sourceforge.net/"
SRC_URI="mirror://sourceforge/pfstools/pfstools/${PV}/${P}.tgz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc imagemagick matlab netpbm octave +openexr opengl qt4 raw +tiff"

DEPEND="
	!media-gfx/pfstmo
	!media-gfx/pfscalibration

	media-libs/opencv
	sci-libs/fftw:3.0
	sci-libs/gsl

	qt4? ( dev-qt/qtgui:4 )
	tiff? ( media-libs/tiff:* )
	netpbm? ( media-libs/netpbm )
	imagemagick? ( <media-gfx/imagemagick-7 )
	openexr? ( media-libs/openexr )
	raw? ( media-gfx/dcraw )
	octave? ( sci-mathematics/octave )
	opengl? ( media-libs/freeglut )
	"

RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's|pfsoutrgbe\.1||' "${S}/src/fileformat/CMakeLists.txt"
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWITH_QT="$(usex qt4)"
		-DWITH_ImageMagick="$(usex imagemagick)"
		-DWITH_Octave="$(usex octave)"
		-DWITH_OpenEXR="$(usex openexr)"
		-DWITH_NetPBM="$(usex netpbm)"
		-DWITH_TIFF="$(usex tiff)"
		-DWITH_pfsglview="$(usex opengl)"
		-DWITH_MATLAB="$(usex matlab)"
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install || die "cmake install failed"
	dodoc AUTHORS README doc/faq.txt

	if use doc; then
		dodoc doc/pfs_format_spec.pdf
	fi
}
