TEMPLATE = app

QT += core qml quick
CONFIG += c++11

INCLUDEPATH += $$PWD/aeslib

include("./aeslib/qaesencryption.pri")

SOURCES += main.cpp \
    encipheror.cpp

RESOURCES += qml.qrc

DEFINES += QT_DEPRECATED_WARNINGS

HEADERS += \
    encipheror.h

