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
git clone https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang

# Set etc/openwrt_release
#sed -i "s/DISTRIB_DESCRIPTION=.*/DISTRIB_DESCRIPTION='ImmortalWrt By Nomex $(date +"%Y%m%d") '/g" package/base-files/files/etc/openwrt_release

# default-settings
#Build_Date=R`date "+%y.%m.%d"`
#sed -i '/exit 0/i\sed -i "s\/DISTRIB_REVISION=.*\/DISTRIB_REVISION='"'${Build_Date}'"'\/g" \/etc\/openwrt_release' package/emortal/default-settings/files/99-default-settings
#sed -i '/exit 0/i\sed -i "s\/DISTRIB_DESCRIPTION=.*\/DISTRIB_DESCRIPTION='"'ImmortalWrt Compile by Nomex ${Build_Date} '"'\/g" \/etc\/openwrt_release\n' package/emortal/default-settings/files/99-default-settings

# 自定义 Luci 显示版本信息
sed -i "/uci apply/i\uci set luci.main.version='ImmortalWrt Compile by Nomex R$(date "+%y.%m.%d")'" feeds/luci/modules/luci-base/root/etc/config/luci
sed -i "/uci apply/i\uci set luci.main.revision='R$(date "+%y.%m.%d")'" feeds/luci/modules/luci-base/root/etc/config/luci
