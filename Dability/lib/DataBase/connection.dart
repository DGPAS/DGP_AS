/*import 'package:mysql1/mysql1.dart';

class MySql {
  static String host = '10.0.2.2',
                user = 'root',
                password = 'root',
                db = 'app';
  static int port = 8889;

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
}*/