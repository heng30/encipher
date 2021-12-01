CONFIG += c++11

DEFINES += QT_DEPRECATED_WARNINGS USE_INTEL_AES_IF_AVAILABLE
QMAKE_CXXFLAGS += -maes

HEADERS += \
    $$PWD/qaesencryption.h \
    $$PWD/aesni/aesni-enc-cbc.h \
    $$PWD/aesni/aesni-enc-ecb.h \
    $$PWD/aesni/aesni-key-exp.h

SOURCES += \
    $$PWD/qaesencryption.cpp
