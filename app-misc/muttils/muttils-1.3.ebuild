# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# Normally you need only one version of this.
PYTHON_COMPAT=( python{2_6,2_7} )

inherit eutils distutils-r1

DESCRIPTION="Utilities for use with console mail clients like Mutt"
HOMEPAGE="https://bitbucket.org/blacktrash/muttils/"
SRC_URI="https://bitbucket.org/blacktrash/${PN}/get/${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	mv *-${PN}-* "${S}/"
}

src_install() {
	distutils-r1_src_install

	docinto contrib
	dodoc contrib/*
}
