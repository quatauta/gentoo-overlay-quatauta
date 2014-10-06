# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/clearlooks-phenix/clearlooks-phenix-9999.ebuild,v 1.4 2013/10/28 22:51:40 hasufell Exp $

EAPI=5

inherit git-2

DESCRIPTION="Clearlooks-Phenix is a GTK+ 3 port of Clearlooks, the default theme for GNOME 2"
HOMEPAGE="https://github.com/jpfleury/clearlooks-phenix"
EGIT_REPO_URI="https://github.com/jpfleury/${PN}.git"
EGIT_BRANCH="v5" # for GTK+ 3.12

KEYWORDS=""
LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND=">=x11-libs/gtk+-3.6:3
	x11-themes/gtk-engines"

src_install() {
	insinto "/usr/share/themes/Clearlooks-Phenix-${SLOT}"
	doins -r *
}
