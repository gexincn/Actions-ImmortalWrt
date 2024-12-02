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
#sed -i 's/192.168.1.1/192.168.2.8/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# Modify OPENWRT_RELEASE
#BUILD_DATE=$(date +'%Y.%m.%d')
#sed -i "s|DISTRIB_DESCRIPTION='%D %V %C'|DISTRIB_DESCRIPTION='%D %A %V Compiled by Nomex, $BUILD_DATE'|g" package/base-files/files/etc/openwrt_release
#sed -i "s|OPENWRT_RELEASE='%D %V %C'|OPENWRT_RELEASE='%D %A %V Compiled by Nomex,$BUILD_DATE'|g" package/base-files/files/usr/lib/os-release

# Modify ImmortalWrt_RELEASE
BUILD_DATE=$(date +'%Y.%m.%d')
sed -i '/DISTRIB_REVISION/d' /etc/openwrt_release
sed -i '/DISTRIB_DESCRIPTION/d' /etc/openwrt_release
echo "DISTRIB_REVISION='Compiled by Nomex,$BUILD_DATE'" >> /etc/openwrt_release
echo "DISTRIB_DESCRIPTION='ImmortalWrt %A'" >> /etc/openwrt_release
echo "" >> package/emortal/default-settings/files/99-default-settings
cat fix_file >> package/emortal/default-settings/files/99-default-settings
rm fix_file

# 添加编译日期前缀到固件文件名
sed -i '/IMG_PREFIX:=/a\BUILD_DATE_PREFIX := $(shell date +"%Y%m%d")' include/image.mk
sed -i "s/IMG_PREFIX:=/IMG_PREFIX:=${BUILD_DATE_PREFIX} /g" include/image.mk

# golang
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang
