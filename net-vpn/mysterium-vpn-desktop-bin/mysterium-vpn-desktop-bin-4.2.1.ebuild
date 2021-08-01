# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DESCRIPTION="Desktop client for the Mysterium Network"
HOMEPAGE="https://mysterium.network"

SRC_URI="https://github.com/mysteriumnetwork/mysterium-vpn-desktop/releases/download/${PV}/mysterium-vpn-desktop_${PV}_amd64.deb"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	exeinto /usr/bin
	rm -r usr/share/doc || die "failed to remove /usr/share/doc"

	cp -r usr "${D}" || die "failed to copy /usr"
	cp -r opt "${D}" || die "failed to copy /opt"

	doexe "${FILESDIR}/mysterium-client"

	#doinitd "${FILESDIR}/myst_supervisor"
	#dosym "/opt/MysteriumVPN/resources/static/bin/myst" "/usr/bin/myst"
	#dosym "/opt/MysteriumVPN/mysterium-vpn-desktop" "/usr/bin/mysterium-vpn-desktop"
}
