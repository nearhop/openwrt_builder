#!/bin/sh
platform=$1
echo "Platform is ..."$platform
if [ "$platform" = "" ]; then
	echo "You need to specify the platform name"
	exit 1
fi

if [ ! -e openwrt ]; then
	git clone https://github.com/openwrt/openwrt.git
	if [ $? -ne 0 ]; then
		echo "Error while cloning openwrt"
		exit 1
	fi
fi
cd openwrt/
git checkout v21.02.2
if [ $? -ne 0 ]; then
	echo "Error while switching openwrt to v21.02.2 branch"
	exit 1
fi
git am ../patches/*.patch
if [ $? -ne 0 ]; then
	echo "Error while applying patches to openwrt"
	exit 1
fi
./build $platform
