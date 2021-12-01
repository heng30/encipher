#include "encipheror.h"
#include "qaesencryption.h"

#include <QCryptographicHash>
#include <QDebug>
#include <qrandom.h>


encipheror::encipheror(const QString &passwd, QObject *parent)
    : QObject(parent)
{
    m_passwd = QCryptographicHash::hash(passwd.toLocal8Bit(), QCryptographicHash::Sha256);
    m_iv = QCryptographicHash::hash(passwd.toLocal8Bit(), QCryptographicHash::Md5);
    m_encryption.reset(new QAESEncryption(QAESEncryption::AES_256, QAESEncryption::CBC));
//    qDebug() << m_passwd.toHex() << m_iv.toHex();
}

QString encipheror::encrypt(const QString &input)
{
    QByteArray encodeText = m_encryption->encode(input.toLocal8Bit(), m_passwd, m_iv);
    return QString::fromLocal8Bit(encodeText.toHex());
}

QString encipheror::decrypt(const QString &input)
{
    QByteArray encodeText = QByteArray::fromHex(input.toLocal8Bit());
    QByteArray decodeText = m_encryption->decode(encodeText, m_passwd, m_iv);
    return QString(m_encryption->removePadding(decodeText));
}

void encipheror::test()
{
    auto _randomStr = [](const int randomStringLength) -> QString {
       static const QString possibleCharacters("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789");
       QString randomString;
       for(int i=0; i<randomStringLength; ++i) {
           int index = rand() % possibleCharacters.length();
           QChar nextChar = possibleCharacters.at(index);
           randomString.append(nextChar);
       }
       return randomString;
    };

    encipheror en(_randomStr(200));
    QString plainText = _randomStr(1000);
    QString encodeText = en.encrypt(plainText);
    QString decodeText = en.decrypt(encodeText);
    Q_ASSERT(plainText == decodeText);

//    qDebug() << plainText;
//    qDebug() << encodeText;
//    qDebug() << decodeText;
}
