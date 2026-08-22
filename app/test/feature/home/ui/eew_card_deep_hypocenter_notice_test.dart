import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

const _notice = '震源の深さが150km以上のため、予想震度は発表されていません';
final _now = DateTime.utc(2026, 8, 22, 12);

void main() {
  testWidgets('深さ150km未満かつ最大震度不明では深発注意文を出さない', (tester) async {
    await _pump(tester, eew: _eew(depth: 10, maxIntensity: .unknown));

    expect(find.text(_notice), findsNothing);
  });

  testWidgets('深さ150km以上かつ最大震度未発表では深発注意文を出す', (tester) async {
    await _pump(tester, eew: _eew(depth: 150));

    expect(find.text(_notice), findsOneWidget);
  });

  testWidgets('深さ150km以上でも最大震度が発表されていれば深発注意文を出さない', (tester) async {
    await _pump(tester, eew: _eew(depth: 200, maxIntensity: .four));

    expect(find.text(_notice), findsNothing);
  });

  testWidgets('PLUM法では深さ150km以上でも深発注意文を出さない', (tester) async {
    await _pump(tester, eew: _eew(depth: 200, isPlum: true));

    expect(find.text(_notice), findsNothing);
  });
}

Future<void> _pump(
  WidgetTester tester, {
  required EewTelegramItem eew,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        locationStreamProvider.overrideWith((ref) => const Stream.empty()),
        timeTickerProvider().overrideWith((ref) => Stream.value(_now)),
      ],
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: <ThemeExtension<dynamic>>[
            DesignSystemThemeExtension.light(),
          ],
        ),
        home: Scaffold(
          body: EewCard(
            eew: eew,
            index: null,
            nowOverride: _now,
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump();
}

EewTelegramItem _eew({
  required int depth,
  JmaIntensity? maxIntensity,
  bool isPlum = false,
}) => EewTelegramItem(
  eventId: 'test',
  status: TelegramStatus.normal,
  infoType: TelegramInfoType.publication,
  serialNo: 1,
  isCanceled: false,
  isLastInfo: false,
  reportTime: _now,
  isPlum: isPlum,
  originTime: _now.subtract(const Duration(seconds: 10)),
  hypocenter: EewHypocenterInfo(
    code: 'h1',
    name: 'テスト',
    magnitude: 5,
    depth: depth,
  ),
  forecastIntensity: EewForecastIntensityInfo(
    regions: const [],
    maxIntensity: maxIntensity,
  ),
);
