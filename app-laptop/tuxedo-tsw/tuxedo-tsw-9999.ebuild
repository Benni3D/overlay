# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 linux-info

DESCRIPTION="Unofficial touchpad switch for TUXEDO laptops"
HOMEPAGE="https://github.com/Benni3D/tuxedo-tsw"
EGIT_REPO_URI="${HOMEPAGE}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

pkg_pretend() {
	local CONFIG_CHECK="~HIDRAW"
	check_extra_config
}

src_prepare() {
	default
}

src_compile() {
	emake DEVICE="$(find_device)" configure
	emake all
}

src_install() {

	# install executable
	exeinto /usr/bin
	doexe tuxedo-tsw

	# install man page
	doman tuxedo-tsw.1

	# install udev rules
	insinto /etc/udev/rules.d
	doins 99-tuxedo-tsw.rules
}

find_device() {
	[ -d "/sys/class/hidraw" ] || die "HIDRAW driver is not loaded"
	for hidraw in /sys/class/hidraw/hidraw*; do
		[ ! -e "${hidraw}/device/uevent" ] && continue
		name=$(grep HID_NAME "${hidraw}/device/uevent")
		[ "${name}" = "HID_NAME=UNIW0001:00 093A:0255" ] && echo "$(basename "${hidraw}")" && return
	done
	die "failed to find touchpad device"
}
