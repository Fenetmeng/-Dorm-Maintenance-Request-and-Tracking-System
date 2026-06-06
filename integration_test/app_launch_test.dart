import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dormitory_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('DormFix app launches successfully', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: DormitoryApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(DormitoryApp), findsOneWidget);
  });
}