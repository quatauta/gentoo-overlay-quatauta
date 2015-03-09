# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21 ruby22"

RUBY_FAKEGEM_RECIPE_TEST="rake"
RUBY_FAKEGEM_RECIPE_DOC="none"
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="Character encoding detection, brought to you by ICU"
HOMEPAGE="https://github.com/brianmario/charlock_holmes"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="dev-libs/icu"

# TODO: bundles 'libmagic' (file), but it is patched
# and tests fail with vanilla 'libmagic'

ruby_add_bdepend "dev-ruby/rake-compiler
	test? ( dev-ruby/rspec:2 )"

# fix underlinking
RUBY_PATCHES=( ${PV}-extconf.patch )

all_ruby_prepare() {
	sed -i -e '/[Bb]undler/d' test/helper.rb || die
}

each_ruby_compile() {
    ${RUBY} -S rake compile || die
}
