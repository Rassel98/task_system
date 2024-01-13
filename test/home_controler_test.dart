import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:task_app/app/data/repository/task_repository.dart';
import 'package:task_app/app/data/models/task_model.dart';
import 'package:task_app/app/modules/home/controllers/home_controller.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  group('HomeController Tests', () {
    late HomeController controller;
    late MockTaskRepository mockTaskRepository;

    setUp(() {
      Get.testMode = true;
      mockTaskRepository = MockTaskRepository();
      controller = HomeController();
      controller.taskRepository = mockTaskRepository;
      final taskModel = TaskModel(
        title: 'Test Title',
        description: 'Test Description',
        status: false,
        createdTime: DateTime.now(),
      );
      when(mockTaskRepository.insertTask(taskModel)).thenAnswer((_) async => 1);
    });

    test('insertTask should add a task to the task list', () async {

      final taskModel = TaskModel(
        title: 'Test Title',
        description: 'Test Description',
        status: false,
        createdTime: DateTime.now(),
      );
      when(mockTaskRepository.insertTask(taskModel)).thenAnswer((_) async => 1);
      controller.titleController.text = taskModel.title;
      controller.descriptionController.text = taskModel.description ?? 'Test Description';
       controller.insertTask();

      expect(controller.getTaskList.length, 1);
      verify(mockTaskRepository.insertTask(taskModel)).called(1);
    });

    test('insertTask should not add a task if insertion fails', () async {

      final taskModel = TaskModel(
        title: 'Test Title',
        description: 'Test Description',
        status: false,
        createdTime: DateTime.now(),
      );
      when(mockTaskRepository.insertTask(taskModel)).thenAnswer((_) async => 0);
      controller.titleController.text = taskModel.title;
      controller.descriptionController.text = taskModel.description ?? 'Test Description';
       controller.insertTask();

      expect(controller.getTaskList.length, 0);
      verify(mockTaskRepository.insertTask(taskModel)).called(1);
    });


    tearDown(() {
      Get.reset();
    });
  });
}
