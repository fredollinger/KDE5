# perl init-repository
unset QTDIR
export PATH="$PWD/qtbase/bin:$PWD/qtrepotools/bin:$PATH"

./configure \
-developer-build -opensource -nomake examples -nomake tests \
-no-gtkstyle \
-confirm-license \
-prefix /opt/qt5 \
-no-phonon-backend \
-no-javascript-jit \
-no-qml-debug \
-no-directfb \
-no-linuxfb \
-no-kms \
-no-glib

./build -j 3
