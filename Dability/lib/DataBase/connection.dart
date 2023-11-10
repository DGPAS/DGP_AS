import 'package:mysql1/mysql1.dart';

class MySql {
  static String host = '10.0.0.2',
                user = 'root',
                password = 'password',
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