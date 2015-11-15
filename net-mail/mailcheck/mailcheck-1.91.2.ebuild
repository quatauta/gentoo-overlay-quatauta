# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit eutils

DESCRIPTION="Check multiple mailboxes/maildirs for mail"
HOMEPAGE="http://mailcheck.sourceforge.net"
SRC_URI="mirror://sourceforge/mailcheck/${PN}_${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin mailcheck
	doman mailcheck.1
	insinto /etc
	doins mailcheckrc
}
