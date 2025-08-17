#!/bin/sh
# esd vim06.sh v0.1.0 (2021-02-22 by MIBonk)
# modified for MIB2Toolbox by Olli & jille
# Info
export PATH=:/proc/boot:/sbin:/bin:/usr/bin:/usr/sbin:/net/mmx/bin:/net/mmx/usr/bin:/net/mmx/usr/sbin:/net/mmx/sbin:/net/mmx/mnt/app/armle/bin:/net/mmx/mnt/app/armle/sbin:/net/mmx/mnt/app/armle/usr/bin:/net/mmx/mnt/app/armle/usr/sbin
export LD_LIBRARY_PATH=/net/mmx/mnt/app/root/lib-target:/net/mmx/mnt/eso/lib:/net/mmx/eso/lib:/net/mmx/mnt/app/usr/lib:/net/mmx/mnt/app/armle/lib:/net/mmx/mnt/app/armle/lib/dll:/net/mmx/mnt/app/armle/usr/lib
export IPL_CONFIG_DIR=/etc/eso/production
export TOPIC=VIM6
VIM=$(on -f mmx /eso/bin/dumb_persistence_reader 0 3221422082 2> /dev/null)
VIM=$(echo $VIM | awk '{print toupper($0)}')  
BC="/eso/hmi/engdefs/scripts/mqb/sbin/bc"

echo "This script will restore VIM to original 6 km/h"

# Include info script
. /eso/hmi/engdefs/scripts/mqb/util_info.sh

# Check if BC is actually present on the unit
if [ ! -f $BC ]; then
	echo "Necessary file (BC) not found, aborting"
	exit 0
fi

# Calculating new checksum
if [ ! -z $VIM 2>/dev/null ]; then
	echo "VIM on Unit: "$VIM""
	POSITION=0
	HEXVALUE=06
	if [ $(echo $HEXVALUE | wc -c) -eq 3 ] ; then	
		HEXVALUE=$(echo $HEXVALUE | awk '{print toupper($0)}') 
		VIM=$(echo $VIM | cut -c1-56)
		LENGTH=$(echo $VIM | wc -c)
		LENGTH=$(echo $LENGTH -3 | $BC)
		if [ $POSITION -le $LENGTH ] && [ $(( $POSITION % 2 )) -eq 0 ]; then
			if [ $POSITION -ge "2" ]; then
				PRI=$(echo $VIM | cut -c1-$POSITION)
			else
				PRE=""
			fi
			if [ $POSITION -ne $LENGTH ]; then
				POSITION=$(echo $POSITION +3 | $BC)
				SEC=$(echo $VIM | cut -c$POSITION-$(echo $LENGTH +2 | $BC))
			else
				SEC=""
			fi
			VIMPATCH=$PRI$HEXVALUE$SEC
			echo "Calculating new checksum"
			# Include CRC utility
			. /eso/hmi/engdefs/scripts/mqb/util_crc16.sh $VIMPATCH
                        # Patching persistence address
			VIMPATCH=$VIMPATCH$crcsum
			on -f mmx /net/mmx/eso/bin/apps/pc b:0:3221422082 $VIMPATCH
			on -f mmx /net/mmx/eso/bin/apps/pc b:0:1 0
			DEZ=$(echo "ibase=16; $HEXVALUE" | $BC)
			echo "VIM is now patched on byte $POSITION with $DEZ km/h (0x$HEXVALUE)"
			echo "System reboot will start soon"
			sleep 5
			# Include reboot utility
			. /eso/hmi/engdefs/scripts/mqb/util_reboot.sh
		else
			echo "Wrong position"
		fi
	else	
		echo "No binary hex digits in value"
	fi
else
	echo "There is no flashpart for VIM!"
fi

exit 0
