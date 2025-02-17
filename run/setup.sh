#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Need argument for your build and install directory (in that order). Use the FULL path. Exiting."
    exit 1
fi

BUILDDIR=$1
INSTALLDIR=$2

cd ..
THISREPODIR=`pwd`

mkdir -p $BUILDDIR/triggercountmodule
cd $BUILDDIR/triggercountmodule
echo "Entered "`pwd`
$THISREPODIR/src/autogen.sh --prefix=$BUILDDIR/triggercountmodule
make clean
make install

cd $THISREPODIR/run
echo "Entered "`pwd`
mkdir -p output/err
mkdir -p outout/out
mkdir -p output/added
mkdir -p subs
mkdir -p lists
mkdir -p /sphenix/tg/tg01/jets/$USER/trigcount

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "EDIT earlydata.sh AND addcommand.sh BY REPLACING THE DIRECTORY"
echo "/sphenix/user/jocl/projects/testinstall TO YOUR INSTALL DIRECTORY"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
