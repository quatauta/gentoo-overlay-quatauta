# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# unicode python script from debian

DESCRIPTION="Display properties for unicode character or search unicode database"
HOMEPAGE="http://packages.debian.org/unstable/utils/unicode"
SRC_URI="ftp://ftp.debian.org/debian/pool/main/u/unicode/${PN}_${PV}.tar.gz"

KEYWORDS="x86 amd64"
LICENSE="GPL-2"
SLOT="0"

IUSE=""
DEPEND=">=dev-lang/python-2.2"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	wget -O "${WORKDIR}/${P}/UnicodeData.txt" http://unicode.org/Public/UNIDATA/UnicodeData.txt
}

src_install() {
	dobin unicode
	dobin paracode
	doman *.1
	dodoc README README-paracode changelog
	insinto /usr/share/${PN}
	doins UnicodeData.txt
}
