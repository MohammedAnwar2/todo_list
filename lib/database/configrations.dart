import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/database/Tables.dart';
class Sqflite {



  static Database?_db;
  Future<Database?>get db async{
    if(_db==null){
      _db = await initSqflit();
      return _db;
    }else{
      return _db;
    }
  }
  initSqflit()async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'LearnSqflite.db');
    Database database = await openDatabase(path,onCreate: _oncreate,version: 7,onUpgrade: _onUpgrade);
    return database;
  }
  _onUpgrade(Database db,int oldVersion,int newVersion)async {
    print("_onUpgrade ==============================");
    // await db.execute("ALTER TABLE notes ADD COLUMN BABY Text ");
    //await db.execute("ALTER TABLE notes DROP COLUMN BABY");
  }
  _oncreate(Database db, int version) async {
    //  Batch batch = Batch();
    await db.execute('''
      CREATE TABLE `${NoteTable.noteTable}` (
        "${NoteTable.col_id}" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT, 
        "${NoteTable.col_title}" TEXT ,
        "${NoteTable.col_date}" TEXT ,
        "${NoteTable.col_priority}" TEXT ,
        "${NoteTable.col_status}" INTEGER 
        )
     ''');

    print("_oncreate ==============================");
  }
  readData({String ?table})async{
    Database?database = await db;
    List<Map> response =await database!.query(table!);//,orderBy: "`id` DESC" // orderBy: "`id` ASC "
    return response;
  }
  insertData({String? table,  Map<String, Object?> ?values})async{
    Database?database = await db;
    int response =await database!.insert(table!,values!);
    return response;
  }
  deleteData({String? table, String ?my_where})async{
    Database?database = await db;
    int response =await database!.delete(table!,where:my_where!);
    return response;
  }
  updateData({String? table, Map<String, Object?>? values, String? my_where})async{
    Database?database = await db;
    int response =await database!.update(table!,values!,where: my_where);
    return response;
  }

  MydeleteDatabase()async{
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'LearnSqflite.db');
    await deleteDatabase(path);
  }
}

