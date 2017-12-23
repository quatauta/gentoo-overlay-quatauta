# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit git-r3 python-r1

DESCRIPTION="Command line tool that generates XDG menus for several window managers"
HOMEPAGE="https://github.com/gapan/xdgmenumaker"
SRC_URI=""
EGIT_REPO_URI="https://github.com/gapan/xdgmenumaker"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	app-text/txt2tags
"
RDEPEND="
	${PYTHON_DEPS}
	dev-python/pyxdg
"

PATCHES=( "${FILESDIR}/xdgmenumaker_ignore-show-only-in.patch"
		  "${FILESDIR}/xdgmenumaker_only-existing.patch"
		  "${FILESDIR}/xdgmenumaker_python2.patch"
		  "${FILESDIR}/xdgmenumaker_upcase-names.patch" )

src_install() {
	emake DESTDIR="${D}" PREFIX="${DESTTREE}" man install
}
