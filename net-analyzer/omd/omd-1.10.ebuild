# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="Open Monitoring Distribution, Nagios, Icinga, Check_MK, PNP4Nagios, NagVis"
HOMEPAGE="http://omdistro.org/ https://github.com/ConSol/omd/"
# SRC_URI=""
EGIT_REPO_URI="https://github.com/ConSol/omd.git"
EGIT_CLONE_TYPE="shallow"
EGIT_COMMIT="v${PV}"

LICENSE="GPL2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="
	+check_mk
	dokuwiki
	gearman
	+icinga
	ldap
	mod_python
	mysql
	nagios
	+nagvis
	nrpe
	nsca
	+pnp4nagios
	shinken
	thruk
"

DEPEND="
	app-arch/unzip
	dev-db/libdbi
	dev-lang/perl
	dev-lang/php[cgi,cli,gd,crypt,sqlite]
	dev-libs/boost
	dev-libs/cloog
	dev-libs/glib
	dev-libs/libevent
	dev-libs/libmcrypt
	dev-libs/libxml2
	dev-libs/openssl
	dev-php/pear
	dev-python/pyro
	dev-python/setuptools
	dev-util/dialog
	media-gfx/graphviz
	media-libs/gd
	net-analyzer/fping
	net-analyzer/net-snmp[perl]
	net-dialup/radiusclient-ng
	net-dns/bind-tools
	net-fs/samba[client]
	net-libs/gnutls
	net-libs/libpcap
	net-misc/curl
	net-misc/rsync
	sys-apps/util-linux
	sys-apps/xinetd
	sys-devel/gettext
	sys-devel/libtool
	sys-devel/patch
	sys-libs/readline
	sys-process/time
	www-apache/mod_fcgid
	www-apache/mod_proxy_html
	x11-libs/cairo
	x11-libs/pango
	virtual/mailx

	check_mk? (
		dev-libs/dietlibc
		ldap? ( dev-python/python-ldap )
		net-analyzer/mk-livestatus
		net-analyzer/nagios-plugins
		net-analyzer/net-snmp[python]
		net-analyzer/traceroute
		www-servers/apache
	)
	dokuwiki? ( www-apps/dokuwiki[gd] )
	gearman? ( sys-libs/ncurses )
	icinga? ( net-analyzer/icinga )
	ldap? ( net-nds/openldap )
	mod_python? ( www-apache/mod_python )
	mysql? ( dev-db/mysql )
	nagios? ( net-analyzer/nagios )
	nagvis? ( net-analyzer/nagvis )
	pnp4nagios? ( net-analyzer/pnp4nagios )
	thruk? ( net-misc/curl[ssl] x11-base/xorg-server[xvfb] )
	nrpe? ( net-analyzer/nrpe )

	dev-perl/Algorithm-C3
	dev-perl/Any-Moose
	dev-perl/AppConfig
	dev-perl/Archive-Zip
	dev-perl/B-Hooks-EndOfScope
	dev-perl/B-Keywords
	dev-perl/Cairo
	dev-perl/Capture-Tiny
	dev-perl/Carp-Clan
	dev-perl/Cgi-Simple
	dev-perl/Class-Accessor
	dev-perl/Class-Accessor-Chained
	dev-perl/Class-C3
	dev-perl/Class-C3-XS
	dev-perl/Class-Data-Inheritable
	dev-perl/Class-Inspector
	dev-perl/Class-Load
	dev-perl/Class-Load-XS
	dev-perl/Class-Method-Modifiers
	dev-perl/Class-MethodMaker
	dev-perl/Class-Singleton
	dev-perl/Clone
	dev-perl/Color-Library
	dev-perl/Config-Any
	dev-perl/Config-Tiny
	dev-perl/Crypt-RC4
	dev-perl/Crypt-Rijndael
	dev-perl/Crypt-SSLeay
	dev-perl/DBD-mysql
	dev-perl/DBI
	dev-perl/Data-Dump
	dev-perl/Data-OptList
	dev-perl/Data-Page
	dev-perl/Data-Visitor
	dev-perl/Date-Calc
	dev-perl/DateTime
	dev-perl/Devel-Caller
	dev-perl/Devel-GlobalDestruction
	dev-perl/Devel-StackTrace
	dev-perl/Devel-StackTrace-AsHTML
	dev-perl/Devel-Symdump
	dev-perl/Digest-Perl-MD5
	dev-perl/Digest-SHA1
	dev-perl/Dist-CheckConflicts
	dev-perl/Email-Address
	dev-perl/Email-Date-Format
	dev-perl/Encode-Locale
	dev-perl/Error
	dev-perl/Eval-Closure
	dev-perl/Exception-Class
	dev-perl/Exporter-Cluster
	dev-perl/FCGI
	dev-perl/FCGI-ProcManager
	dev-perl/Fatal-Exception
	dev-perl/File-BOM
	dev-perl/File-Copy-Recursive
	dev-perl/File-Listing
	dev-perl/File-Remove
	dev-perl/File-SearchPath
	dev-perl/File-ShareDir
	dev-perl/File-Slurp
	dev-perl/File-chdir
	dev-perl/Filesys-Notify-Simple
	dev-perl/Font-TTF
	dev-perl/GD
	dev-perl/Gearman
	dev-perl/Getopt-Long-Descriptive
	dev-perl/Graphics-ColorNames
	dev-perl/Graphics-ColorNames-WWW
	dev-perl/Graphics-ColorObject
	dev-perl/HTML-Parser
	dev-perl/HTML-Tagset
	dev-perl/HTTP-Body
	dev-perl/HTTP-Cookies
	dev-perl/HTTP-Daemon
	dev-perl/HTTP-Date
	dev-perl/HTTP-Message
	dev-perl/HTTP-Negotiate
	dev-perl/Hash-MultiValue
	dev-perl/IO-String
	dev-perl/IO-stringy
	dev-perl/Ima-DBI
	dev-perl/JSON
	dev-perl/JSON-Any
	dev-perl/JSON-XS
	dev-perl/LWP-MediaTypes
	dev-perl/LWP-Protocol-https
	dev-perl/List-MoreUtils
	dev-perl/Log-Log4perl
	dev-perl/MIME-Lite
	dev-perl/MIME-Types
	dev-perl/MRO-Compat
	dev-perl/Math-Base36
	dev-perl/Math-Calc-Units
	dev-perl/Module-Find
	dev-perl/Module-Implementation
	dev-perl/Module-Install
	dev-perl/Module-Runtime
	dev-perl/Module-ScanDeps
	dev-perl/Module-Versions-Report
	dev-perl/Moose
	dev-perl/MooseX-Aliases
	dev-perl/MooseX-AttributeHelpers
	dev-perl/MooseX-ClassAttribute
	dev-perl/MooseX-ConfigFromFile
	dev-perl/MooseX-Getopt
	dev-perl/MooseX-GlobRef
	dev-perl/MooseX-MultiInitArg
	dev-perl/MooseX-Object-Pluggable
	dev-perl/MooseX-Role-Parameterized
	dev-perl/MooseX-SimpleConfig
	dev-perl/MooseX-StrictConstructor
	dev-perl/MooseX-Types
	dev-perl/MooseX-Types-Path-Class
	dev-perl/Nagios-Plugin
	dev-perl/Net-HTTP
	dev-perl/PAR-Dist
	dev-perl/PPI
	dev-perl/PPIx-Regexp
	dev-perl/PPIx-Utilities
	dev-perl/Package-DeprecationManager
	dev-perl/Package-Stash
	dev-perl/Package-Stash-XS
	dev-perl/PadWalker
	dev-perl/Params-Util
	dev-perl/Params-Validate
	dev-perl/Parse-ErrorString-Perl
	dev-perl/Parse-RecDescent
	dev-perl/Path-Class
	dev-perl/Period
	dev-perl/Perl-Critic
	dev-perl/Perl-Critic-Deprecated
	dev-perl/Perl-Critic-Dynamic
	dev-perl/Perl-Critic-Nits
	dev-perl/Perl-Critic-Policy-Dynamic-NoIndirect
	dev-perl/Perl6-Junction
	dev-perl/Plack
	dev-perl/Pod-Coverage
	dev-perl/Pod-Spell
	dev-perl/Readonly
	dev-perl/Set-Infinite
	dev-perl/Set-Object
	dev-perl/Spreadsheet-ParseExcel
	dev-perl/Spreadsheet-WriteExcel
	dev-perl/Stream-Buffered
	dev-perl/String-Format
	dev-perl/String-RewritePrefix
	dev-perl/Sub-Exporter
	dev-perl/Sub-Exporter-Progressive
	dev-perl/Sub-Identify
	dev-perl/Sub-Install
	dev-perl/Sub-Name
	dev-perl/Sys-SigAction
	dev-perl/Task-Weaken
	dev-perl/Template-Toolkit
	dev-perl/Term-ProgressBar
	dev-perl/Term-ReadLine-Gnu
	dev-perl/Term-ShellUI
	dev-perl/TermReadKey
	dev-perl/Test-Perl-Critic
	dev-perl/Test-Pod
	dev-perl/Test-Pod-Coverage
	dev-perl/Tie-IxHash
	dev-perl/Tie-ToObject
	dev-perl/Tree-Simple
	dev-perl/Try-Tiny
	dev-perl/UNIVERSAL-isa
	dev-perl/URI
	dev-perl/Variable-Magic
	dev-perl/WWW-RobotRules
	dev-perl/XML-LibXML
	dev-perl/XML-NamespaceSupport
	dev-perl/XML-Parser
	dev-perl/XML-SAX
	dev-perl/XML-SAX-Base
	dev-perl/XML-Simple
	dev-perl/XML-Twig
	dev-perl/YAML-Syck
	dev-perl/YAML-Tiny
	dev-perl/boolean
	dev-perl/common-sense
	dev-perl/config-general
	dev-perl/constant-boolean
	dev-perl/extutils-depends
	dev-perl/extutils-pkgconfig
	dev-perl/indirect
	dev-perl/libwww-perl
	dev-perl/log-dispatch
	dev-perl/namespace-autoclean
	dev-perl/namespace-clean
	dev-perl/net-server
	dev-perl/perltidy
	dev-perl/string-crc32
	dev-perl/yaml
	perl-core/Archive-Tar
	perl-core/Attribute-Handlers
	perl-core/CPAN
	perl-core/Compress-Raw-Bzip2
	perl-core/Compress-Raw-Zlib
	perl-core/Data-Dumper
	perl-core/Devel-PPPort
	perl-core/Digest-MD5
	perl-core/Encode
	perl-core/Exporter
	perl-core/ExtUtils-Constant
	perl-core/ExtUtils-MakeMaker
	perl-core/ExtUtils-Manifest
	perl-core/ExtUtils-ParseXS
	perl-core/File-Path
	perl-core/File-Temp
	perl-core/Filter
	perl-core/Getopt-Long
	perl-core/IO
	perl-core/IO-Compress
	perl-core/IO-Zlib
	perl-core/IPC-Cmd
	perl-core/JSON-PP
	perl-core/Locale-Maketext-Simple
	perl-core/MIME-Base64
	perl-core/Math-Complex
	perl-core/Module-Build
	perl-core/Module-CoreList
	perl-core/Module-Load
	perl-core/Module-Load-Conditional
	perl-core/Module-Loaded
	perl-core/Module-Metadata
	perl-core/Module-Pluggable
	perl-core/Package-Constants
	perl-core/Params-Check
	perl-core/Parse-CPAN-Meta
	perl-core/Perl-OSType
	perl-core/Pod-Escapes
	perl-core/Pod-Simple
	perl-core/Scalar-List-Utils
	perl-core/Socket
	perl-core/Storable
	perl-core/Sys-Syslog
	perl-core/Test-Simple
	perl-core/Text-Balanced
	perl-core/Text-ParseWords
	perl-core/Text-Tabs+Wrap
	perl-core/Thread-Queue
	perl-core/Thread-Semaphore
	perl-core/Time-HiRes
	perl-core/Time-Local
	perl-core/Version-Requirements
	perl-core/XSLoader
	perl-core/libnet
	perl-core/parent
	perl-core/podlators
	perl-core/threads
	perl-core/threads-shared
	perl-core/version
"
RDEPEND="${DEPEND}"

OMD_PACKAGES=""
OMD_PACKAGES="${OMD_PACKAGES} perl-modules"
OMD_PACKAGES="${OMD_PACKAGES} python-modules"
OMD_PACKAGES="${OMD_PACKAGES} apache-omd"
OMD_PACKAGES="${OMD_PACKAGES} mod_python"
OMD_PACKAGES="${OMD_PACKAGES} check_logfiles"
OMD_PACKAGES="${OMD_PACKAGES} check_mk"
OMD_PACKAGES="${OMD_PACKAGES} check_multi"
OMD_PACKAGES="${OMD_PACKAGES} check_mysql_health"
OMD_PACKAGES="${OMD_PACKAGES} check_oracle_health"
OMD_PACKAGES="${OMD_PACKAGES} check_webinject"
OMD_PACKAGES="${OMD_PACKAGES} dokuwiki"
OMD_PACKAGES="${OMD_PACKAGES} example"
OMD_PACKAGES="${OMD_PACKAGES} jmx4perl"
OMD_PACKAGES="${OMD_PACKAGES} mk-livestatus"
OMD_PACKAGES="${OMD_PACKAGES} mysql-omd"
OMD_PACKAGES="${OMD_PACKAGES} icinga"
OMD_PACKAGES="${OMD_PACKAGES} nagios"
OMD_PACKAGES="${OMD_PACKAGES} nagios-plugins"
OMD_PACKAGES="${OMD_PACKAGES} nagvis"
OMD_PACKAGES="${OMD_PACKAGES} nrpe"
OMD_PACKAGES="${OMD_PACKAGES} nsca"
OMD_PACKAGES="${OMD_PACKAGES} omd"
OMD_PACKAGES="${OMD_PACKAGES} pnp4nagios"
OMD_PACKAGES="${OMD_PACKAGES} rrdtool"
OMD_PACKAGES="${OMD_PACKAGES} shinken"
OMD_PACKAGES="${OMD_PACKAGES} thruk"
OMD_PACKAGES="${OMD_PACKAGES} maintenance"
OMD_PACKAGES="${OMD_PACKAGES} gearmand"
OMD_PACKAGES="${OMD_PACKAGES} mod-gearman"
OMD_PACKAGES="${OMD_PACKAGES} patch"
OMD_PACKAGES="${OMD_PACKAGES} nail"
OMD_PACKAGES="${OMD_PACKAGES} notifications-tt"

OMD_BUILD_PACKAGES=""
OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} perl-modules"
OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} python-modules"
OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} apache-omd"
# OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} mod_python"
OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} check_logfiles"
# OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} check_mk"
OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} check_multi"
OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} check_mysql_health"
OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} check_oracle_health"
OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} check_webinject"
# OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} dokuwiki"
OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} example"
OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} jmx4perl"
# OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} mk-livestatus"
OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} mysql-omd"
# OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} icinga"
# OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} nagios"
# OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} nagios-plugins"
# OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} nagvis"
# OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} nrpe"
use nsca && OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} nsca"
OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} omd"
# OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} pnp4nagios"
# OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} rrdtool"
use shinken && OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} shinken"
use thruk   && OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} thruk"
OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} maintenance"
OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} gearmand"
OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} mod-gearman"
# OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} patch"
# OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} nail"
OMD_BUILD_PACKAGES="${OMD_BUILD_PACKAGES} notifications-tt"

src_unpack() {
	git-r3_src_unpack
	echo $OMD_BUILD_PACKAGES
}

src_prepare() {
	cp "${FILESDIR}/Makefile.GENTOO_2.2" "${S}/distros/Makefile.GENTOO_2.2" || die "Could not copy Gentoo Makefile"
	epatch "${FILESDIR}/distro-lsb-release.patch" || die "Could not patch distros script to use lsb_release"
	epatch "${FILESDIR}/makefile-for-gentoo.patch" || die "Could not patch Makefile"
}

src_configure() {
	./configure PACKAGES="${OMD_PACKAGES}" || die "Error running configure"
	echo PACKAGES = ${OMD_PACKAGES} > "${S}/.config" || die "Could not write package list to .config"
}

src_compile() {
	local PKG

	for PKG in ${OMD_BUILD_PACKAGES} ; do
		make -C "packages/${PKG}" DESTDIR="${D}" P5TMPDIST="${WORKDIR}/perl5-tmp-dist" build || true
	done
}

src_install() {
	local PKG

	mkdir -p "${D}/opt/omd" || die "Could not create /opt/omd/"
	ln -s "${D}/opt/omd" "${D}/omd" || die "Could not symlink /omd -> /opt/omd "

	for PKG in ${OMD_PACKAGES} ; do
		make -C "packages/${PKG}" DESTDIR="${D}" P5TMPDIST="${WORKDIR}/perl5-tmp-dist" install || true
	done

	emake PACKAGES="${OMD_PACKAGES}" pack || die "Error running make pack"
	emake PACKAGES="${OMD_PACKAGES}" install-global || die "Error running install-global"
	ln -fs "/opt/omd" "${D}/omd" || die "Could not symlink /omd -> /opt/omd "
}
