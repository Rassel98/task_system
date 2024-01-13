import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task_app/app/data/interface/task_interface.dart';
import 'package:task_app/app/data/models/task_model.dart';
import 'package:task_app/app/utils/helpers.dart';
import '../../../data/db/local_db_helper.dart';
import '../../../data/repository/task_repository.dart';

class HomeController extends GetxController {
  RxBool isStatus = false.obs;
  RxBool isLoading = true.obs;
  late TaskInterface taskInterface;
  GlobalKey<FormState> formKeys = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final _taskList = <TaskModel>[].obs;
  List<TaskModel> get getTaskList => _taskList;

  Rx<List<TaskModel>> _searchTask = Rx<List<TaskModel>>([]);
  List<TaskModel> get searchTask => _searchTask.value;

  late TaskRepository taskRepository;

  @override
  void onInit() {
    super.onInit();
    taskRepository = TaskRepository();
    getAllTask();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    titleController.clear();
    descriptionController.clear();
    close();
  }

  void insertTask() async {
    if (!formKeys.currentState!.validate()) {
      return;
    }
    TaskModel taskModel = TaskModel(
      title: titleController.text,
      description: descriptionController.text,
      status: isStatus.value,
      createdTime: DateTime.now(),
    );

    int insertedId = await taskRepository.insertTask(taskModel);
    if (insertedId > 0) {
      taskModel.id = insertedId;
      _taskList.add(taskModel);
      titleController.clear();
      descriptionController.clear();
      showMessage(title: "Success !!", message: "Data inserted successfully.", duration: 3);
      print('Data inserted successfully. Inserted ID: $insertedId');
    } else {
      showMessage(
        title: "Error",
        message: "Failed to insert data.",
      );
      print('Failed to insert data.');
    }
  }

  void updateTask(TaskModel model, int index) async {
    if (!formKeys.currentState!.validate()) {
      return;
    }
    TaskModel taskModel = TaskModel(
      id: model.id,
      title: titleController.text,
      description: descriptionController.text,
      status: isStatus.value,
      createdTime: model.createdTime,
    );
    int insertedId = await taskRepository.updateTask(taskModel);
    if (insertedId > 0) {
      _taskList.removeAt(index);
      _taskList.insert(index, taskModel);
      showMessage(title: "Success !!", message: "Task update successfully.", duration: 3);
    } else {
      showMessage(
        title: "Error",
        message: "Failed to update task.",
      );
      print('Failed to update Task.');
    }
  }

  void deleteTask(TaskModel taskModel) async {
    int delete = await taskRepository.deleteTask(taskModel.id!);
    if (delete > 0) {
      _taskList.remove(taskModel);
      showMessage(title: "Success !!", message: "Task delete successfully.", duration: 3);
    } else {
      showMessage(
        title: "Error",
        message: "Failed to delete task.",
      );
    }
  }

  void getAllTask() async {
    var response = await taskRepository.getAllTasks();
    if (response.isNotEmpty) {
      print('All tasks:');
      _taskList.addAll(response);
      runFilter("");
      isLoading(false);
    } else {
      isLoading(false);
      print('No tasks found in the database.');
    }
  }

  void close() => taskRepository.close();

  void runFilter(String enterKey) {
    if (enterKey.isEmpty) {
      _searchTask.value = getTaskList;
    } else {
      _searchTask.value = getTaskList.where((element) => element.title.toLowerCase().contains(enterKey.toLowerCase())).toList();
    }
  }
}
