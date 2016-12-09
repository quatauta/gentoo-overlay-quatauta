# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit systemd unpacker user

DESCRIPTION="The binary Fedora 23 package of the GitLab CI Multi Runner."
HOMEPAGE="https://gitlab.com/gitlab-org/gitlab-ci-multi-runner"
LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
MY_PN="${PN%-bin}"
SRC_DIST="debian/buster"
SRC_ARCH="amd64"
MY_P="${MY_PN}_${PV}_${SRC_ARCH}.deb"
SRC_URI="https://packages.gitlab.com/runner/${MY_PN}/packages/${SRC_DIST}/${MY_P}/download -> ${MY_P}"
IUSE="docker"
RDEPEND="docker? ( app-emulation/docker )"

src_unpack() {
	mkdir "${S}"
	cd "${S}"
	unpacker ${A}
}

src_install() {
	exeinto /usr/bin
	doexe usr/bin/gitlab-ci-multi-runner
	insinto /usr/bin
	dosym gitlab-ci-multi-runner /usr/bin/gitlab-runner

	insinto /usr/share/gitlab-runner
	doins usr/share/gitlab-runner/clear-docker-cache
	doins usr/share/gitlab-runner/post-install
	doins usr/share/gitlab-runner/pre-remove

	dodoc usr/share/doc/gitlab-ci-multi-runner/changelog.gz

	systemd_dounit "${FILESDIR}/gitlab-runner.service"

	dodir /etc/gitlab-runner
	touch "${D}/etc/gitlab-runner/config.toml"
	chmod 600 "${D}/etc/gitlab-runner/config.toml"

	dodir "/var/lib/gitlab-runner"
	fowners gitlab_runner "/var/lib/gitlab-runner"
}

pkg_setup() {
	if use docker ; then
		enewuser "gitlab_runner" -1 /bin/bash "/var/lib/gitlab-runner" "docker"
		elog "User gitlab_runner added to group docker."
		elog "This is insecure and allows root access."
	else
		enewuser "gitlab_runner" -1 /bin/bash "/var/lib/gitlab-runner"
	fi
}
