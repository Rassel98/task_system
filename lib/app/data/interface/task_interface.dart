import '../models/task_model.dart';

abstract  class  TaskInterface {
  Future<int> insertTask(TaskModel taskModel);
  Future<TaskModel?> getTaskById(int taskId);
  Future<List<TaskModel>> getAllTasks();
  Future<int> updateTask(TaskModel taskModel);
  Future<int> deleteTask(int id);
  Future close();
}
