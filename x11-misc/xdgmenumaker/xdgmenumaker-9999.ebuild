# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit base git-r3 python-r1

DESCRIPTION="Command line tool that generates XDG menus for several window managers"
HOMEPAGE="https://github.com/gapan/xdgmenumaker"
SRC_URI=""
EGIT_REPO_URI="https://github.com/gapan/xdgmenumaker"

LICENSE="GPLv3"
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

PATCHES=( "${FILESDIR}/xdgmenumaker_upcase-name_show-all_check-path.patch" )

src_prepare() {
	base_src_prepare
	sed -i -e "s|/usr/share/|${DESTTREE}/share/|g" \
		"src/xdgmenumaker" || die "Adjusting paths in src/xdgmenumaker failed"
}

src_compile() {
	txt2tags -o "man/xdgmenumaker.1" "man/xdgmenumaker.t2t" || die "Creating man page failed"
}

src_install() {
	dobin "src/xdgmenumaker"
	doman "man/xdgmenumaker.1"
	insinto "/usr/share/desktop-directories"
	doins "desktop-directories"/*
}
