import 'package:dio/dio.dart';
import 'package:eqmonitor/core/component/error/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpAndOpen(WidgetTester tester, Object error) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showErrorDialog(context, error: error),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  testWidgets('メッセージと詳細・閉じるを表示する', (tester) async {
    await pumpAndOpen(tester, Exception('boom'));
    expect(find.text('詳細'), findsOneWidget);
    expect(find.text('閉じる'), findsOneWidget);
  });

  testWidgets('DioException のステータスを既定タイトルに含む', (tester) async {
    final dio = DioException(
      requestOptions: RequestOptions(path: '/x'),
      response: Response<dynamic>(
        requestOptions: RequestOptions(path: '/x'),
        statusCode: 503,
      ),
    );
    await pumpAndOpen(tester, dio);
    expect(find.textContaining('503'), findsOneWidget);
  });
}
