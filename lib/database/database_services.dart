import 'dart:io';
import 'package:hookup4u/models/thread_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static DatabaseHelper _databaseHelper;
  static Database _database;

  static final _databaseName = "KundaliDatabase.db";
  static final _databaseVersion = 1;

  static final messages = 'messages';

  /// message columns
  static final columnId = 'id';
  static final columnSenderId = 'sender_id';
  static final columnThreadId = 'thread_id';
  static final columnSentTime = 'date_sent';
  static final columnSentMessage = 'sent_message';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
         onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $messages (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnSenderId INTEGER,
            $columnThreadId INTEGER,
            $columnSentTime TEXT,
            $columnSentMessage TEXT
          )
          ''');
  }

  Future<int> insert(ThreadModel message) async {
    Database db = await this.database;
    return await db.insert(messages, message.toMap());
  }

  Future<List<ThreadModel>> getAllMessages() async {
    Database db = await this.database;
    List<Map<String, dynamic>> list = await db.query(messages);
    List<ThreadModel> messagesList = list.map((model) => ThreadModel.fromMapObject(model)).toList();
    return messagesList;
  }

  Future<List<ThreadModel>> getSingleUserMessages(int threadId) async {
    Database db = await this.database;
    print("Thread ID: $threadId");
    List<Map<String, dynamic>> list = await db.rawQuery('SELECT * FROM $messages WHERE $columnThreadId = ?',[threadId]);
    List<ThreadModel> messagesList = list.map((model) => ThreadModel.fromMapObject(model)).toList();
    print("Database List -> ${messagesList.length}");
    return messagesList;
  }

  Future<List<ThreadModel>> getLastMessage(int threadId) async {
    Database db = await this.database;
    print("Thread ID: $threadId");
    List<Map<String,dynamic>> list = await db.rawQuery('SELECT * FROM $messages WHERE $columnThreadId = ? ORDER BY $columnSentTime DESC LIMIT 1',[threadId]);
    print("Database List -> $list");
    List<ThreadModel> messagesList = list.map((model) => ThreadModel.fromMapObject(model)).toList();
    print("Database List -> ${messagesList.length}");
    return messagesList;
  }

  Future clearMessageDatabase() async {
    Database db = await this.database;
    return await db.execute('''DELETE FROM $messages''');
  }

  Future clearThreadMessageDatabase(int threadId) async {
    Database db = await this.database;
    print("Thread ID: $threadId");
    return await db.execute('''DELETE FROM $messages WHERE $columnThreadId = $threadId''');
  }

  Future checkThreadDatabase(int threadId) async {
    Database db = await this.database;
    return await db.rawQuery('SELECT $columnThreadId FROM $messages WHERE $columnThreadId = ? ',[threadId]);
  }

}