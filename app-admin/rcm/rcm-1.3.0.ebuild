# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools eutils git-2

DESCRIPTION="Management suite for dotfiles"
HOMEPAGE="https://github.com/thoughtbot/rcm"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"

EGIT_REPO_URI="https://github.com/thoughtbot/rcm.git"
EGIT_COMMIT="v1.3.0"

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
