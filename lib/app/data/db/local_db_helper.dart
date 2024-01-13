import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_app/app/data/models/task_model.dart';

class DBHelper {
  DBHelper._init();
  static const String createTaskTable = '''CREATE TABLE $tableTask(
      $tabTaskColId INTEGER PRIMARY KEY AUTOINCREMENT,
      $tabTaskColTitle TEXT NOT NULL,
      $tabTaskColDescription TEXT,
      $tabTaskColStatus BOOLEAN NOT NULL,
      $tabTaskColCreatedAt TEXT
      )''';
  static final DBHelper instance = DBHelper._init();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'task.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        db.execute(createTaskTable);
      },
    );
  }

  Future<int> insertTask(TaskModel taskModel) async {
    try {
      final db = await instance.database;
      return db.insert(tableTask, taskModel.toMap());
    } catch (e) {
      log('error: $e');
      return 0;
    }
  }

  Future<List<TaskModel>> getAllTasks() async {
    try {
      final db = await instance.database;
      final List<Map<String, dynamic>> mapList = await db.query(tableTask, orderBy: '$tabTaskColCreatedAt DESC');
      return List.generate(mapList.length, (index) => TaskModel.fromMap(mapList[index]));
    } catch (e) {
      return [];
    }
  }

  Future<TaskModel?> getTaskById(int id) async {
    try {
      final db = await instance.database;
      final mapList = await db.query(tableTask, where: '$tabTaskColId= ?', whereArgs: [id]);
      return TaskModel.fromMap(mapList.first);
    } catch (e) {
      return null;
    }
  }

  Future<int> updateTask(TaskModel taskModel) async {
    try {
      final db = await instance.database;
      return db.update(
        tableTask,
        taskModel.toMap(),
        where: '$tabTaskColId = ?',
        whereArgs: [taskModel.id],
      );
    } catch (e) {
      return 0;
    }
  }

  Future<int> deleteTask(int id) async {
    try {
      final db = await instance.database;
      return db.delete(tableTask, where: '$tabTaskColId= ?', whereArgs: [id]);
    } catch (e) {
      print(e.toString());
      return 0;
    }
  }

  Future close() async {
    try {
      final db = await instance.database;
      db.close();
    } catch (e) {
      log('error: $e');
    }
  }
}
