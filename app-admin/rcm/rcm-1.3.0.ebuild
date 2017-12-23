# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils git-r3

DESCRIPTION="Management suite for dotfiles"
HOMEPAGE="https://github.com/thoughtbot/rcm"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"

EGIT_REPO_URI="https://github.com/thoughtbot/rcm.git"
EGIT_COMMIT="v1.3.0"

DEPEND="dev-ruby/mustache"

src_prepare() {
	eapply_user
	eautoreconf
	maint/autocontrib man/rcm.7.mustache
}

src_configure() {
	econf
}

src_install() {
	emake DESTDIR="${D}" install
}
