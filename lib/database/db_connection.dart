import 'package:mysql1/mysql1.dart';

class DBConnection{

  static ConnectionSettings dbConnection(){
    var settings = ConnectionSettings(
        host: 'db5015850444.hosting-data.io',
        port: 3306,
        user: 'dbu1837358',
        password: 'nayon@918772',
        db: 'dbs12920903'
    );
    return settings;
  }

}