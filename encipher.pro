TEMPLATE = app

QT += core qml quick
CONFIG += c++17 release
RC_ICONS = favicon.ico

DEFINES += QT_DEPRECATED_WARNINGS

INCLUDEPATH += $$PWD/aeslib
include("./aeslib/qaesencryption.pri")

RESOURCES += qml.qrc

HEADERS += \
    encipher.h

SOURCES += main.cpp \
    encipher.cpp

MOC_DIR = build
RCC_DIR = build
# DESTDIR = build
OBJECTS_DIR = build
