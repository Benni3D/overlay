# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="The brainlet C compiler"
HOMEPAGE="https://github.com/Benni3D/bcc"

LICENSE="GPL-2"
SLOT="0"

if [ "${PV}" = "9999" ]; then
	EGIT_REPO_URI="https://github.com/Benni3D/bcc.git"
	inherit git-r3
else
	SRC_URI="https://github.com/Benni3D/bcc/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DEPEND="dev-lang/nasm"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	default
	#sed -i 's|CC=cc|CC+=|' util/config.mk || die "sed fix failed."
}

src_compile() {
	emake -j1
}

src_install() {
	emake PREFIX="${D}/usr" install
}

src_test() {
	emake -j1 test
	rm -f /tmp/test.c /tmp/test.o
}
