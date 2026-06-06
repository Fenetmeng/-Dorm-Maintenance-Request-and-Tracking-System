import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dormitory_app/features/requests/presentation/providers/request_provider.dart';

void main() {
  group('RequestProvider Riverpod Test', () {
    test('initial request state should be empty', () {
      final container = ProviderContainer();

      addTearDown(container.dispose);

      final state = container.read(requestProvider);

      expect(state.requests, isEmpty);
      expect(state.isLoading, false);
      expect(state.errorMessage, null);
    });
  });
}