# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Unofficial keyboard backlight control for TUXEDO laptops"
HOMEPAGE="https://github.com/Benni3D/tuxedo-polaris-backlight-control"
EGIT_REPO_URI="${HOMEPAGE}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-laptop/tuxedo-keyboard"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	exeinto /usr/bin
	doexe tuxedo-keylight
}

pkg_postinst() {
	elog "The resulting binary is called tuxedo-keylight"
}
