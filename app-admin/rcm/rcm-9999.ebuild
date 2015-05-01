# Copyright 2014 Anton Ilin
# Copyright 2014 Kaleb Elwert
# Distributed under the terms of the MIT LICENSE

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
