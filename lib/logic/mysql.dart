import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = 'krshi.ctg9o8le8cfj.us-east-1.rds.amazonaws.com',
                user = 'krshi',
                password = 'Krshi_123321',
                db = 'krshi';
  static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: db
    );
    return await MySqlConnection.connect(settings);
  }
}