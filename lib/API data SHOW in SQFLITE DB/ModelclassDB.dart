import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB_Model {
  Future<Database> Geting_DATA() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'APIDATA.db');
    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'create table MY_APIdata (id integer primary key autoincrement,title Text,name Text,no Text)');
    });
    return database;
  }

  Future<List<Map>> ViewMY_Data(Database View_database) async {
    String View_QUERY = "Select * From MY_APIdata";

    List<Map> ViewData_listtt = await View_database.rawQuery(View_QUERY);
    return ViewData_listtt;
  }

  Future<void> Insertdata(int i, int j, int k, Database database0) async {
    String insertqry =
        "Insert into MY_APIdata (title,name,no) values ('${i}','${j}','${k}')";
    int cnt = await database0.rawInsert(insertqry);
    print("aaaa==${cnt}");
  }
}
