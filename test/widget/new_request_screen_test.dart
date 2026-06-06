import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dormitory_app/features/requests/presentation/screens/new_request_screen.dart';

void main() {
  testWidgets('NewRequestScreen displays form fields', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: NewRequestScreen(),
        ),
      ),
    );

    expect(find.text('New Request'), findsOneWidget);
    expect(find.text('Category'), findsOneWidget);
    expect(find.text('Location'), findsOneWidget);
    expect(find.text('Room Number'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
    expect(find.text('Submit Request'), findsOneWidget);
  });
}