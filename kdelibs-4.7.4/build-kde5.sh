#!/bin/sh

export QTDIR=../../qt5
export PATH=$QTDIR/qtbase/bin:$PATH
export LD_LIBRARY_PATH=$QTDIR/lib:../../../kde5/lib:$LD_LIBRARY_PATH:/host/kd5/lib:/usr/lib/x86_64-linux-gnu
export PKG_CONFIG_PATH=../../../kde5/lib/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig
export SHAREDDESKTOPONTOLOGIES_ROOT_DIR=/host/kde5

mkdir -p build
cd build && cmake .. &>err

