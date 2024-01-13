import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:task_app/app/data/models/task_model.dart';
import 'package:task_app/app/modules/home/controllers/home_controller.dart';
import 'package:task_app/app/modules/home/views/home_view.dart';

class MockHomeController extends Mock implements HomeController {
  @override
  RxBool get isLoading => RxBool(false); // Corrected this line
}

void main() {
  group('HomeView Tests', () {
    late MockHomeController mockController;

    setUp(() {
      mockController = MockHomeController();
    });

    testWidgets('show "No Data Found" when task list is empty', (WidgetTester tester) async {
      when(mockController.isLoading.value).thenReturn(false);
      when(mockController.getTaskList).thenReturn([]);
      await tester.pumpWidget(
        const GetMaterialApp(
          home: HomeView(),
        ),
      );
      expect(find.text('No Data Found !!'), findsOneWidget);
    });

    testWidgets('show tasks when task list is not empty', (WidgetTester tester) async {
      final taskModel = TaskModel(
        title: 'Test Title',
        description: 'Test Description',
        status: false,
        createdTime: DateTime.now(),
      );

      when(mockController.isLoading.value).thenReturn(false);
      when(mockController.getTaskList).thenReturn([taskModel]);
      await tester.pumpWidget(
        const GetMaterialApp(
          home: HomeView(),
        ),
      );
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
    });

    tearDown(() {
      Get.reset();
    });
  });
}
