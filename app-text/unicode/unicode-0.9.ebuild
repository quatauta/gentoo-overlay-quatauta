# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# unicode python script from debian

DESCRIPTION="unicode is a simple command line utility that displays properties for a given unicode character, or searches unicode database for a given namenext generation distributed version control"
HOMEPAGE="http://packages.debian.org/unstable/utils/unicode"
SRC_URI="ftp://ftp.debian.org/debian/pool/main/u/unicode/${PN}_${PV}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

IUSE=""
DEPEND=">=dev-lang/python-2.2"

src_install() {
	dobin unicode
	dobin paracode
	doman *.1
	dodoc README README-paracode changelog
}
