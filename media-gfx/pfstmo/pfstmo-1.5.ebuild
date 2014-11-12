# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit autotools-utils

DESCRIPTION="Implementation of tone mapping operators for PFStools"
HOMEPAGE="http://pfstools.sourceforge.net/pfstmo.html"
SRC_URI="mirror://sourceforge/pfstools/pfstmo/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="fftw"

DEPEND="
	>=media-gfx/pfstools-1.8.2
	>=sci-libs/gsl-1.14
	fftw? ( sci-libs/fftw:3.0 )
	"

RDEPEND="${DEPEND}"

DOCS=(AUTHORS README TODO)
