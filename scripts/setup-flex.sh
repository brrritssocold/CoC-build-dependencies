#!/bin/sh
FLEX_VERSION='4.16.1'
PLAYER_VERSION_MAJOR='28'
PLAYER_VERSION_MINOR='0'
PLAYER_VERSION="$PLAYER_VERSION_MAJOR.$PLAYER_VERSION_MINOR"

PLAYER_VERSION_URL=$PLAYER_VERSION_MAJOR'_'$PLAYER_VERSION_MINOR

GLOBAL_PLAYER_DIR="frameworks/libs/player/$PLAYER_VERSION"
GLOBAL_PLAYER_PATH="$GLOBAL_PLAYER_DIR/playerglobal.swc"

echo "==================================="
echo "Setting up apache flex SDK $FLEX_VERSION"
echo "==================================="

wget -N "http://www-eu.apache.org/dist/flex/$FLEX_VERSION/binaries/apache-flex-sdk-$FLEX_VERSION-bin.tar.gz"
tar zxf "apache-flex-sdk-$FLEX_VERSION-bin.tar.gz"
cp -r "apache-flex-sdk-$FLEX_VERSION-bin" "flex"
cd "flex"
ant -f installer.xml -Dflash.donot.ask=true -Dair.donot.ask=true -Dfontswf.donot.ask=true

FLEX_MIN_VERSION=$(grep -Po "(?<=<target-player>)(\d*\.\d*)(?=</target-player>)" frameworks/flex-config.xml)

if [ "$FLEX_MIN_VERSION" != "$PLAYER_VERSION" ]
then
	echo "Player version mismatch! Flex SDK min version: $FLEX_MIN_VERSION, script player version: $PLAYER_VERSION"
	echo "Update the PLAYER_VERSION_* variables in devTools/ci/setup-flex.sh to match $FLEX_MIN_VERSION"
	exit 1
fi

echo "Creating $GLOBAL_PLAYER_DIR"
mkdir -vp $GLOBAL_PLAYER_DIR
echo "==============================================="
echo "Downloading flash player global $PLAYER_VERSION"
echo "==============================================="

if ! wget -N "http://download.macromedia.com/get/flashplayer/updaters/$PLAYER_VERSION_MAJOR/playerglobal$PLAYER_VERSION_URL.swc" ; then
	echo "wget exit code: $?"
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo "! FAILED TO DOWNLOAD GLOBAL PLAYER SWC! ELVIS HAS LEFT THE BUILDING! !"
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	exit
fi

cp -v "playerglobal$PLAYER_VERSION_URL.swc" $GLOBAL_PLAYER_PATH

cd ..

echo "==============================================="
echo "Downloading flash player for Linux"
echo "==============================================="

# Setup flash player. You read that right! Flash player for linux is back!
wget -N https://fpdownload.macromedia.com/pub/labs/flashruntimes/flashplayer/linux64/flash_player_sa_linux.x86_64.tar.gz
tar zxf flash_player*

echo "==============================================="
echo "Copy build result to git repository"
echo "==============================================="

mkdir -p /vagrant/bin/
cp -r flex /vagrant/bin/
# Remove it after copy so re-runs will not download the file repeatedly
rm /vagrant/bin/flex/playerglobal*
cp flashplayer /vagrant/bin/
