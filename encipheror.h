#ifndef ENCIPHEROR_H
#define ENCIPHEROR_H

#include <QByteArray>
#include <QObject>
#include <QScopedPointer>
#include <QString>

#include "qaesencryption.h"

class encipheror : public QObject {
  Q_OBJECT

 public:
  explicit encipheror(const QString passwd = QString(),
                      QObject *parent = nullptr);
  ~encipheror() = default;

  Q_INVOKABLE void setPasswd(const QString &passwd);
  Q_INVOKABLE QString encrypt(const QString &input);
  Q_INVOKABLE QString decrypt(const QString &input);
  Q_INVOKABLE bool verify(const QString &input);
  static void test(int testCnt);

 private:
  QByteArray m_passwd;
  QByteArray m_iv;
  QScopedPointer<QAESEncryption> m_encryption;
};

#endif  // ENCIPHEROR_H
