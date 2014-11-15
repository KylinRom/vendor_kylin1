#!/bin/bash
# KylinRom build script
# v1.0.0

# Setup enviroment

# Colors
red=$(tput setaf 1)             #  red
grn=$(tput setaf 2)             #  green
blu=$(tput setaf 4)             #  blue
cya=$(tput setaf 6)             #  cyan
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldgrn=${txtbld}$(tput setaf 2) #  green
bldblu=${txtbld}$(tput setaf 4) #  blue
bldcya=${txtbld}$(tput setaf 6) #  cyan
txtrst=$(tput sgr0)             # Reset

if [ "KylinRom$1" = "KylinRom" ]; then
   echo "${bldcya}Kylin Rom${txtrst}"
   echo "${cya}Usage: './mk [Device] {Variable}'${txtrst}"
   echo "   Device: your device name"
   echo "   Variable: functions"
   echo "    -  fix      : start build without any cleanning for fix build"
   echo "    -  clean    : run 'mka installclean' before build"
   echo "    -  allclean : run 'mka clean' before build"
   echo "    -  sync     : run 'repo sync' before build"
   echo " "
   exit 0
fi

# Get build version
VERSION_A=$(cat vendor/kylin/config/version.mk | grep 'VERSION_A = *' | sed  's/VERSION_A = //g')
VERSION_B=$(cat vendor/kylin/config/version.mk | grep 'VERSION_B = *' | sed  's/VERSION_B = //g')
BUILDTYPE=$(cat vendor/kylin/config/version.mk | grep 'BUILDTYPE = *' | sed  's/BUILDTYPE = //g')

VERSION=$VERSION_A.$VERSION_B-$BUILDTYPE
if [ "$BUILDTYPE" = "DAILY" ]; then
    VERSION=$VERSION_A.$VERSION_B-$BUILDTYPE-`date -u +%Y%m%d`
fi

# Set ccache
export USER_CCACHE=1
if [ -f ".ccache_dir" ]; then
    export CCACHE_DIR=`cat .ccache_dir | sed -n '1p'`
    size=`cat .ccache_dir | sed -n '2p'`
    prebuilts/misc/linux-x86/ccache/ccache -M "$size"G
else
    echo "please specify ccache directory"
    read cache_dir
    echo $cache_dir > .ccache_dir
    echo "please specify ccache size, in GB"
    read cache_size
    echo $cache_size >> .ccache_dir
fi

DEVICE=$1
TASK=$2

. build/envsetup.sh
echo ""
if [ -z "$DEVICE" ]; then
    echo "please input a device name!"
    exit 0
fi

fix=0
lunchFlag=0
if [ ! -z "$TASK" ]; then
    if [ "$TASK" = "sync" ]; then
        echo "${bldblu}Fetching sources${txtrst}"
        repo sync
        echo ""
    elif [ "$TASK" = "clean" ]; then
        echo "${bldblu}Clear images${txtrst}"
        lunch kylin_$DEVICE-userdebug
        lunchFlag=1
        mka installclean
        echo ""
    elif [ "$TASK" = "allclean" ]; then
        echo "${bldblu}Clear entire build path${txtrst}"
        lunch kylin_$DEVICE-userdebug
        lunchFlag=1
        mka clean
        echo ""
    elif [ "$TASK" = "fix" ]; then
        echo "Skipping remove build.prop"
        fix=1
    fi
fi

if [ "$fix" -eq 0 ]; then
    echo "Removing build.prop"
    rm -f $OUT/system/build.prop
fi

echo ""
if [ "$lunchFlag" -eq 0 ]; then
    lunch kylin_$DEVICE-userdebug
fi

clear
echo -e "${bldcya}Building KylinRom $VERSION for $DEVICE${txtrst}";
echo -e "${bldgrn}Start time: $(date) ${txtrst}"
res1=$(date +%s.%N)
mka bacon
echo ""

res2=$(date +%s.%N)
echo -e "${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds)${txtrst}"
