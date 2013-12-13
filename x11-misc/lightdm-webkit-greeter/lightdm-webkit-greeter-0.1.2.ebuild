# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lightdm-gtk-greeter/lightdm-gtk-greeter-1.3.1.ebuild,v 1.1 2012/09/11 20:31:01 hwoarang Exp $

EAPI=5

inherit autotools base eutils pax-utils

if [[ ${PV##*.} = 9999 ]]; then
	EBZR_PROJECT="lightdm-webkit-greeter"
	EBZR_BRANCH="facebrowser-theme"
	EBZR_REPO_URI="lp:~and471/lightdm-webkit-greeter/facebrowser-theme"
	# "Nosmart" is much faster for initial branching.
	EBZR_INITIAL_URI="nosmart+${EBZR_REPO_URI}"
	inherit bzr
	SRC_URI=""
else
	SRC_URI="http://launchpad.net/lightdm-webkit-greeter/trunk/${PV}/+download/${P}.tar.gz"
fi

DESCRIPTION="LightDM Webkit Greeter"
HOMEPAGE="http://launchpad.net/lightdm-webkit-greeter"
SRC_URI="http://launchpad.net/lightdm-webkit-greeter/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="net-libs/webkit-gtk:2
	x11-libs/gtk+:2
	dev-libs/dbus-glib
	>=x11-misc/lightdm-1.2.2"
RDEPEND="!!<x11-misc/lightdm-1.1.1
	>=x11-misc/lightdm-1.2.2"

src_prepare() {
	sed -i -e 's/liblightdm-gobject-0/liblightdm-gobject-1/g' configure.ac

	if [[ ${PV##*.} = 9999 ]]; then
		AT_M4DIR=m4 eautoreconf
	fi
}

src_install() {
	base_src_install

	# Set PaX markings for hardened/PaX (bug #344267)
	pax-mark m $( list-paxables $( find "${D}" ) )
}
