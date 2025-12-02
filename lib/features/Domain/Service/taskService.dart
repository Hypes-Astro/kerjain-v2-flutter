import 'package:kerjain/features/Data/Managers/LocalDataManager.dart';
import 'package:kerjain/features/Domain/Models/taskModel.dart';

class TaskService {

  Future<List<TaskModel>> getAllTasks() async {
    final tasks = await LocalDataManager.getTasks();
    for (final t in tasks) {
    print('[DB] id=${t.id}, title=${t.title}, status=${t.status}');
  }
    return await LocalDataManager.getTasks();
  }

  Future<int> addTask(TaskModel task) async {
    return await LocalDataManager.addTask(task);
  }

  Future<int> updateTask(TaskModel task) async {
    if (task.id == null) {
      throw Exception('Task id is required to update');
    }
    return await LocalDataManager.updateTask(task);
  }

  Future<int> deleteTask(int id) async {
    return await LocalDataManager.deleteTask(id);
  }

  Future<List<TaskModel>> getTasksByStatus(int status) async {
    final all = await LocalDataManager.getTasks();
    return all.where((t) => t.status == status).toList();
  }
}
