#include <QDebug>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "encipher.h"

int main(int argc, char* argv[]) {
  QGuiApplication app(argc, argv);
  QQmlApplicationEngine engine;
  //  encipher::test(1000);
  engine.rootContext()->setContextProperty("encipher", new encipher());
  engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
  return app.exec();
}
