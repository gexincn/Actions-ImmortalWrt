#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# 删除 feeds.conf 中的 passwall 项，避免 feeds 拉取旧版本
sed -i '/passwall/d' feeds.conf.default

# 强制使用最新版 Passwall（直接 clone 源码）
rm -rf package/passwall
rm -rf package/passwall_packages
git clone https://github.com/xiaorouji/openwrt-passwall package/passwall
git clone https://github.com/xiaorouji/openwrt-passwall-packages package/passwall_packages

# mosdns（移除旧 geodata & mosdns）
find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ./ | grep Makefile | grep mosdns | xargs rm -f

git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# OpenClash 最新版
rm -rf feeds/luci/applications/luci-app-openclash
rm -rf package/openclash
git clone https://github.com/vernesong/OpenClash.git package/openclash

# 禁止 OpenClash 自动下载核心（避免 GHA /tmp 爆满）
# 只保留空目录，运行后设备会自动下载核心
rm -rf package/openclash/luci-app-openclash/root/etc/openclash/core
mkdir -p package/openclash/luci-app-openclash/root/etc/openclash/core
