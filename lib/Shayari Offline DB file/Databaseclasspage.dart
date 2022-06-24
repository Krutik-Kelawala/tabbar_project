import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database? db;

  Future<Database> Getalldata() async {
    // Construct a file path to copy database to
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Shayari.db");

// Only copy if the database doesn't exist
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      // Load database from asset and copy
      ByteData data = await rootBundle.load(join('assetsdb', 'Shayari.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Save copied asset to documents
      await new File(path).writeAsBytes(bytes);
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String databasePath = join(appDocDir.path, 'Shayari.db');
      db = await openDatabase(databasePath);
      // var initialized = true;
    }
    return openDatabase(path);
  }

  Future<List<Map>> Viewdatalist(Database database) async {
    String viewquery = "Select * From AllShayariCategory";
    List<Map> viewlist = await database.rawQuery(viewquery);
    print("Data==${viewlist}");
    return viewlist;
  }

  Future<List<Map>> Viewdetailshy(Database databaseview) async {
    String viewdetaiallshy = "Select * From AllShayari";
    List<Map> View_shyari = await databaseview.rawQuery(viewdetaiallshy);
    print("Viewshyy=  ${View_shyari}");
    return View_shyari;
  }
}
