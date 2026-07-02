import 'package:eqmonitor/core/component/error/error_details_sheet.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('要約とバージョン情報を表示し、まとめてコピーが押せる', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          deviceIdProvider.overrideWith((_) async => 'device-123'),
          packageInfoProvider.overrideWithValue(
            PackageInfo(
              appName: 'EQMonitor',
              packageName: 'app.eqmonitor',
              version: '2.6.0',
              buildNumber: '4200',
            ),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showErrorDetailsSheet(
                  context,
                  error: Exception('boom'),
                ),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(find.textContaining('まとめてコピー'), findsOneWidget);
    expect(find.textContaining('2.6.0'), findsWidgets);
  });
}
