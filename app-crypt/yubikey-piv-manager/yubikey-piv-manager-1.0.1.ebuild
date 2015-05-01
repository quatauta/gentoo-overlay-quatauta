# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/yubikey-neo-manager/yubikey-neo-manager-1.2.1.ebuild,v 1.1 2015/04/14 07:05:05 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Configure your PIV-enabled YubiKey with X509 certificate"
HOMEPAGE="https://developers.yubico.com/yubikey-piv-manager/"
SRC_URI="https://developers.yubico.com/${PN}/Releases/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

CDEPEND="
	dev-python/pyside[webkit,${PYTHON_USEDEP}]
	app-crypt/yubico-piv-tool
	"

DEPEND="
	dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/pycrypto[${PYTHON_USEDEP}]
	${CDEPEND}"

RDEPEND="${CDEPEND}"

DOCS=( COPYING ChangeLog NEWS README )
