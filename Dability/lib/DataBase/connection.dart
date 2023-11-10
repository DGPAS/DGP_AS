import 'package:mysql1/mysql1.dart';
import 'dart:core';

class MySql {
  static String host = 'localhost',
                user = 'root',
                password = '1234',
                db = 'prueba';
  static int port = 3306;

  MySql();

  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
        host: host,
        port: port,
        user: user,
        password: password,
        db: db,
    );

    return await MySqlConnection.connect(settings);
  }
}