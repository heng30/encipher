#ifndef ENCIPHEROR_H
#define ENCIPHEROR_H

#include "qaesencryption.h"

#include <QObject>
#include <QString>
#include <QByteArray>
#include <QScopedPointer>

class encipheror: QObject
{
    Q_OBJECT

public:
    explicit encipheror(const QString &passwd, QObject *parent = nullptr);
    ~encipheror() = default;

    Q_INVOKABLE QString encrypt(const QString &input);
    Q_INVOKABLE QString decrypt(const QString &input);
    static void test();

private:
    QByteArray m_passwd;
    QByteArray m_iv;
    QScopedPointer<QAESEncryption> m_encryption;
};

#endif // ENCIPHEROR_H
