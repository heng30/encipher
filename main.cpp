#include <QDebug>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "encipheror.h"

int main(int argc, char* argv[]) {
  QGuiApplication app(argc, argv);
  QQmlApplicationEngine engine;
  //  encipheror::test(1000);
  engine.rootContext()->setContextProperty("encipheror", new encipheror());
  engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
  return app.exec();
}
