import 'package:eqmonitor/feature/onboarding/ui/component/onboarding_provisioning_error_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('device registration error details can be viewed and copied', (
    tester,
  ) async {
    const details = 'Exception: device registration failed';
    final messenger = TestDefaultBinaryMessengerBinding.instance;
    messenger.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          return null;
        }
        return null;
      },
    );
    addTearDown(() {
      messenger.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      );
    });

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () async => showDialog<void>(
                context: context,
                builder: (context) =>
                    const OnboardingProvisioningErrorDetailsDialog(
                      details: details,
                    ),
              ),
              child: const Text('詳細情報を見る'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('詳細情報を見る'));
    await tester.pumpAndSettle();

    expect(find.text('エラー詳細'), findsOneWidget);
    expect(find.text(details), findsOneWidget);
    expect(find.text('コピー'), findsOneWidget);

    await tester.tap(find.text('コピー'));
    await tester.pump();

    expect(find.text('エラー詳細をコピーしました'), findsOneWidget);
  });
}
