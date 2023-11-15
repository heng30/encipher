#include <QCryptographicHash>
#include <QDebug>
#include <qrandom.h>

#include "encipher.h"
#include "qaesencryption.h"

encipher::encipher(const QString passwd, QObject *parent)
    : QObject(parent) {
    setPasswd(passwd);
}

void encipher::setPasswd(const QString &passwd) {
    m_passwd = QCryptographicHash::hash(passwd.toLocal8Bit(),
                                        QCryptographicHash::Sha256);
    m_iv =
        QCryptographicHash::hash(passwd.toLocal8Bit(), QCryptographicHash::Md5);
    m_encryption.reset(
        new QAESEncryption(QAESEncryption::AES_256, QAESEncryption::CBC));
}

QString encipher::encrypt(const QString &input) {
    QByteArray encodeText =
        m_encryption->encode(input.toLocal8Bit(), m_passwd, m_iv);
    return QString::fromLocal8Bit(encodeText.toHex());
}

QString encipher::decrypt(const QString &input) {
    QByteArray encodeText = QByteArray::fromHex(input.toLocal8Bit());
    QByteArray decodeText = m_encryption->decode(encodeText, m_passwd, m_iv);
    return QString(m_encryption->removePadding(decodeText));
}

bool encipher::verify(const QString &input) {
    QString encodeText = encrypt(input);
    QString decodeText = decrypt(encodeText);
    return input == decodeText;
}

bool encipher::validEncryptText(const QString &input) {
    static QString hexStr("0123456789abcdef");
    if (input.length() % 32 != 0)
        return false;

    for (int i = 0; i < input.length(); i++)
        if (-1 == hexStr.indexOf(input[i].toLower()))
            return false;

    return true;
}

void encipher::test(int testCnt) {
    auto _randomStr = [](const int randomStringLength) -> QString {
        static const QString possibleCharacters(
            "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789");
        QString randomString;
        for (int i = 0; i < randomStringLength; ++i) {
            int index = rand() % possibleCharacters.length();
            QChar nextChar = possibleCharacters.at(index);
            randomString.append(nextChar);
        }
        return randomString;
    };

    for (int i = 0; i < testCnt; i++) {
        encipher en(_randomStr(rand() % 200 + 1));
        QString plainText = _randomStr(rand() % 1000 + 1);
        QString encodeText = en.encrypt(plainText);
        QString decodeText = en.decrypt(encodeText);
        Q_ASSERT(plainText == decodeText);
        //    Q_ASSERT(encodeText.length() % 32 == 0);
    }

    qDebug() << "TEST OK!!!";
}
