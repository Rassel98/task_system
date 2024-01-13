
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:task_app/app/data/models/task_model.dart';
import 'package:task_app/app/modules/home/controllers/home_controller.dart';
import 'package:task_app/app/modules/home/views/new_task_view.dart';

class MockHomeController extends Mock implements HomeController {}

void main() {
  group('NewTaskView Tests', () {
    late MockHomeController mockController;

    setUp(() {
      Get.testMode = true; // Enable Get.testMode
      mockController = MockHomeController();
    });

    testWidgets('display New Task title when taskModel is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: NewTaskView(taskModel: null),
        ),
      );

      expect(find.text('New Task'), findsOneWidget);
      expect(find.text('Edit Task'), findsNothing);
    });

    testWidgets('display Edit Task title when taskModel is not null', (WidgetTester tester) async {
      final taskModel = TaskModel(
        title: 'Test Title',
        description: 'Test Description',
        status: false,
        createdTime: DateTime.now(),
      );
      await tester.pumpWidget(
        GetMaterialApp(
          home: NewTaskView(taskModel:taskModel, idx: 0),
        ),
      );

      expect(find.text('Edit Task'), findsOneWidget);
      expect(find.text('New Task'), findsNothing);
    });

    testWidgets('insertTask when Save button is pressed', (WidgetTester tester) async {
      when(mockController.insertTask()).thenAnswer((_) async {});
      await tester.pumpWidget(
        const GetMaterialApp(
          home: NewTaskView( taskModel: null),
        ),
      );
      await tester.tap(find.text('Save'));

    });



    tearDown(() {
      Get.reset();
    });
  });
}
