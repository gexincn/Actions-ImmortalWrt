#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# 删除 feeds.conf 中的 passwall 项，避免 feeds 拉取旧版本
sed -i '/passwall/d' feeds.conf.default

# Passwall 最新版（保持原逻辑，但浅克隆极大节省空间）
rm -rf package/passwall
rm -rf package/passwall_packages
git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall package/passwall-luci
git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall-packages package/passwall-packages

# mosdns（移除旧 geodata & mosdns）
find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ./ | grep Makefile | grep mosdns | xargs rm -f

git clone --depth=1 https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone --depth=1 https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# OpenClash 最新版（保持原逻辑，但浅克隆）
rm -rf feeds/luci/applications/luci-app-openclash
rm -rf package/openclash
git clone --depth=1 https://github.com/vernesong/OpenClash.git package/openclash

# 禁止 OpenClash 自动下载核心（保持原逻辑）
rm -rf package/openclash/luci-app-openclash/root/etc/openclash/core
mkdir -p package/openclash/luci-app-openclash/root/etc/openclash/core
