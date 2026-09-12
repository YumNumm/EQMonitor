import 'dart:async';

import 'package:eqmonitor/core/component/layout/history_adaptive_view.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/earthquake_history_details_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('読み込み中とエラー時も分割表示だけ戻るボタンを隠す', (tester) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final result = Completer<Earthquake>();
    var closed = false;
    final navigator = GlobalKey<NavigatorState>();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          earthquakeHistoryDetailsProvider('event').overrideWith(
            () => _PendingDetails(result.future),
          ),
        ],
        child: MaterialApp(
          navigatorKey: navigator,
          theme: ThemeData.light().copyWith(
            extensions: [DesignSystemThemeExtension.light()],
          ),
          home: const SizedBox.shrink(),
        ),
      ),
    );
    unawaited(
      navigator.currentState?.push<void>(
        MaterialPageRoute(
          builder: (context) => HistoryAdaptiveView(
            list: const Text('一覧'),
            detail: EarthquakeHistoryDetailsPage(
              eventId: 'event',
              onClose: () => closed = true,
            ),
            onCloseDetail: () => closed = true,
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(BackButton), findsNothing);

    tester.view.physicalSize = const Size(600, 900);
    await tester.pump();
    expect(find.byType(BackButton), findsOneWidget);

    result.completeError(StateError('test error'));
    await tester.pump();
    await tester.pump();
    expect(find.byType(BackButton), findsOneWidget);

    tester.view.physicalSize = const Size(1200, 900);
    await tester.pump();
    expect(find.byType(BackButton), findsNothing);

    tester.view.physicalSize = const Size(600, 900);
    await tester.pump();
    await tester.tap(find.byType(BackButton));
    expect(closed, isTrue);
  });
}

final class _PendingDetails extends EarthquakeHistoryDetailsNotifier {
  new(this.result);

  final Future<Earthquake> result;

  @override
  Future<Earthquake> build(String eventId) => result;
}
