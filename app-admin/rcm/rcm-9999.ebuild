# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/rcm/rcm-9999.ebuild,v 0.1 2015/05/14 19:22:00 jlec Exp $

EAPI=5

inherit autotools eutils git-2

DESCRIPTION="Management suite for dotfiles"
HOMEPAGE="https://github.com/thoughtbot/rcm"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"

EGIT_REPO_URI="https://github.com/thoughtbot/rcm.git"
# EGIT_COMMIT="v1.2.3"

DEPEND="dev-ruby/mustache"

src_prepare() {
	eautoreconf
	maint/autocontrib man/rcm.7.mustache
}

src_configure() {
	econf
}

src_install() {
	emake DESTDIR="${D}" install
}
