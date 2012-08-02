SOURCES += \
moc_HelloWidget.cpp \
HelloWidget.cpp \
main.cpp \
MainWindow.cpp \
moc_MainWindow.cpp

INCLUDES += \
HelloWidget.h \
MainWindow.h
 
#OTHER_FILES += \
#    qml/Test/main.qml
 
QT += quick
 
install_it.path = $${M_BUILDDIR}
 
for(FILE, OTHER_FILES){
   install_it.files += $${FILE}
}
 
INSTALLS += install_it

LIBS += \
-L /opt/qt5/lib \
-lQtWidgets
