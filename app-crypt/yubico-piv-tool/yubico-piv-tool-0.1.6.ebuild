# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/yubikey-neo-manager/yubikey-neo-manager-1.2.1.ebuild,v 1.1 2015/04/14 07:05:05 jlec Exp $

EAPI=5

inherit eutils

DESCRIPTION="Configure your PIV-enabled YubiKey with X509 certificate"
HOMEPAGE="https://developers.yubico.com/yubico-piv-tool/"
SRC_URI="https://developers.yubico.com/${PN}/Releases/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

CDEPEND="
	sys-apps/pcsc-lite
	"

DEPEND="${CDEPEND}"

RDEPEND="${CDEPEND}"

DOCS=( COPYING ChangeLog NEWS README )
