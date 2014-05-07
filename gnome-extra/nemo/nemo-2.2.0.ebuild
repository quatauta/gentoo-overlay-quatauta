# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools eutils gnome2 virtualx git-r3

DESCRIPTION="A file manager for Cinnamon, forked from Nautilus"
HOMEPAGE="http://cinnamon.linuxmint.com/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/linuxmint/nemo.git"
EGIT_COMMIT="${PV}"

LICENSE="GPL-2+ LGPL-2+ FDL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="exif +introspection tracker xmp" # doc

COMMON_DEPEND="
	>=dev-libs/glib-2.31.9:2
	>=x11-libs/pango-1.28.3
	>=x11-libs/gtk+-3.3.17:3[introspection?]
	>=dev-libs/libxml2-2.7.8:2
	>=gnome-extra/cinnamon-desktop-1.0.0

	dev-python/polib
	gnome-base/dconf:=
	gnome-base/gsettings-desktop-schemas
	>=x11-libs/libnotify-0.7:=
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender

	exif? ( >=media-libs/libexif-0.6.20:= )
	introspection? ( >=dev-libs/gobject-introspection-0.6.4 )
	tracker? ( >=app-misc/tracker-0.12:= )
	xmp? ( >=media-libs/exempi-2.1.0:= )
"
RDEPEND="${COMMON_DEPEND}
	gnome-base/gnome-panel
	x11-themes/gnome-icon-theme-symbolic
"
DEPEND="${COMMON_DEPEND}
	>=dev-lang/perl-5
	>=dev-util/gdbus-codegen-2.31.0
	dev-util/gtk-doc-am
	>=dev-util/intltool-0.40.1
	sys-devel/gettext
	virtual/pkgconfig
	x11-proto/xproto

	dev-util/gtk-doc
	gnome-base/gnome-common
"
# For eautoreconf
#	gnome-base/gnome-common, dev-util/gtk-doc (not only -am!)
PDEPEND=">=gnome-base/gvfs-0.1.2"

src_prepare() {
	# upstream fixes, drop on next release
	epatch "${FILESDIR}"/0001-Use-gksu-instead-of-pkexec-until-systemd-glib-whatev.patch

	eautoreconf # no configure in tarball
	gnome2_src_prepare
}

src_configure() {
	# FIXME: add $(use_enable doc gtk-doc) once gnome.eclass supports it in EAPI5
	gnome2_src_configure \
		--disable-update-mimedb \
		$(use_enable exif libexif) \
		$(use_enable introspection) \
		$(use_enable tracker) \
		$(use_enable xmp)
}

src_test() {
	if ! [[ -f "${EROOT}usr/share/glib-2.0/schemas/org.nemo.gschema.xml" ]]; then
		ewarn "Skipping tests because Nemo gsettings schema are not installed."
		ewarn "To run the tests, a version of ${CATEGORY}/${PN} needs to be"
		ewarn "already installed."
		return
	fi
	gnome2_environment_reset
	unset DBUS_SESSION_BUS_ADDRESS
	export GSETTINGS_BACKEND="memory"
	cd src # we don't care about translation tests
	Xemake check
	unset GSETTINGS_BACKEND
}
