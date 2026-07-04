import 'package:eqmonitor/core/component/error/error_details_sheet.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void> _pumpAndOpenSheet(WidgetTester tester) async {
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
        theme: ThemeData.light().copyWith(
          extensions: <ThemeExtension<dynamic>>[
            DesignSystemThemeExtension.light(),
          ],
        ),
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
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('要約とバージョン情報を表示し、まとめてコピーが押せる', (tester) async {
    await _pumpAndOpenSheet(tester);

    expect(find.textContaining('まとめてコピー'), findsOneWidget);
    expect(find.textContaining('2.6.0'), findsWidgets);
  });

  testWidgets('まとめてコピーをタップするとSnackBarが表示される', (tester) async {
    // Mock flutter/platform so Clipboard.setData completes without MissingPluginException
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (MethodCall call) async => null,
    );

    await _pumpAndOpenSheet(tester);

    await tester.tap(find.textContaining('まとめてコピー'));
    await tester.pump(); // process tap, start async onPressed
    await tester.pump(); // clipboard future resolves, showSnackBar called
    await tester.pump(const Duration(milliseconds: 50)); // SnackBar renders

    expect(find.text('エラー詳細をコピーしました'), findsOneWidget);
  });
}
