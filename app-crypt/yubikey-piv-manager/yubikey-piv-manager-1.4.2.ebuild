# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 python3_3 python3_4 python3_5)

inherit distutils-r1

DESCRIPTION="Configure your PIV-enabled YubiKey with X509 certificate"
HOMEPAGE="https://developers.yubico.com/yubikey-piv-manager/"
SRC_URI="https://github.com/Yubico/${PN}/releases/download/${P}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

CDEPEND="
	dev-python/nose
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
