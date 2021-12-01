TEMPLATE = app

QT += core qml quick
CONFIG += c++17
RC_ICONS = favicon.ico

DEFINES += QT_DEPRECATED_WARNINGS

INCLUDEPATH += $$PWD/aeslib
include("./aeslib/qaesencryption.pri")

RESOURCES += qml.qrc

HEADERS += \
    encipheror.h

SOURCES += main.cpp \
    encipheror.cpp



