#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# 修复上移下移按钮翻译
sed -i 's/<%:Up%>/<%:Move up%>/g' feeds/luci/modules/luci-compat/luasrc/view/cbi/tblsection.htm
sed -i 's/<%:Down%>/<%:Move down%>/g' feeds/luci/modules/luci-compat/luasrc/view/cbi/tblsection.htm

# golang
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang

# os-release
echo "Using BUILD_DATE_SHORT=$BUILD_DATE_SHORT"
sed -i "s|OPENWRT_RELEASE=\"%D %V %C\"|OPENWRT_RELEASE=\"%D %V compiled by Nomex, $BUILD_DATE_SHORT\"|g" package/base-files/files/usr/lib/os-release

# Modify filename, add date prefix
echo "Using BUILD_DATE_FULL=$BUILD_DATE_FULL"
sed -i "s/IMG_PREFIX:=/IMG_PREFIX:=${BUILD_DATE_FULL}-/1" include/image.mk

#  Modify TTYD
#sed -i 's|/bin/login|/bin/login -f root|' package/emortal/ttyd/files/ttyd.init

# Set password
#sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.::0:99999:7:::/g' openwrt/package/base-files/files/etc/shadow

# workaround: rust ci-llvm 404 (temporary)
if grep -q "ci-llvm=true" feeds/packages/lang/rust/Makefile; then
  sed -i 's/ci-llvm=true/ci-llvm=false/g' feeds/packages/lang/rust/Makefile
fi
