import 'package:kerjain/features/Domain/Models/taskModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDataManager {
  static const _dbName = 'task_manager.db';
  static const _tableName = 'tasktable';

  static Future<Database> _getDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $_tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            desc TEXT NOT NULL,
            dueDate TEXT NOT NULL,
            status INTEGER NOT NULL
          )
        ''');

        // noted lif, 0 = notStarted, 1 = inProgress, 2 = done
        await db.insert(_tableName, {
          'title': 'tes1',
          'desc': 'tes desc',
          'dueDate': '2025-01-01',
          'status': 1, 
        });

        await db.insert(_tableName, {
          'title': 'tes2',
          'desc': 'tes desc2',
          'dueDate': '2025-01-02',
          'status': 0,
        });
      },
    );

    return database;
  }

  static Future<List<TaskModel>> getTasks() async {
    final db = await _getDatabase();
    final result = await db.query(_tableName);
    return result.map((json) => TaskModel.fromMap(json)).toList();
  }

  static Future<int> addTask(TaskModel taskData) async {
    final db = await _getDatabase();
    return await db.insert(_tableName, taskData.toMap());
  }

  static Future<int> updateTask(TaskModel taskData) async {
    final db = await _getDatabase();
    return await db.update(
      _tableName,
      taskData.toMap(),
      where: 'id = ?',
      whereArgs: [taskData.id],
    );
  }

  static Future<int> deleteTask(int id) async {
    final db = await _getDatabase();
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
