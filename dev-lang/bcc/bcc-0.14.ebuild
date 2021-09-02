# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="The brainlet C compiler"
HOMEPAGE="https://github.com/Benni3D/bcc"

IUSE="+fp -bcl"

LICENSE="GPL-3"
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
}

src_compile() {
	local confargs
	if use fp; then
		confargs+=" --enable-fp"
	else
		confargs+=" --disable-fp"
	fi
	if use bcl; then
		confargs+=" --enable-bcl"
	fi
	econf --prefix=/usr ${confargs}
	emake -j1
}

src_install() {
	emake DESTDIR="${D}" install
}

src_test() {
	emake -j1 test
	rm -f /tmp/test.c /tmp/test.o
}
