import '../db/local_db_helper.dart';
import '../interface/task_interface.dart';
import '../models/task_model.dart';

class TaskRepository extends TaskInterface {
  DBHelper dbHelper = DBHelper.instance;
  @override
  Future<List<TaskModel>> getAllTasks() => dbHelper.getAllTasks();

  @override
  Future<TaskModel?> getTaskById(int taskId) => dbHelper.getTaskById(taskId);

  @override
  Future<int> insertTask(TaskModel taskModel) => dbHelper.insertTask(taskModel);

  @override
  Future close() => dbHelper.close();

  @override
  Future<int> deleteTask(int id) => dbHelper.deleteTask(id);

  @override
  Future<int> updateTask(TaskModel taskModel) => dbHelper.updateTask(taskModel);
}
