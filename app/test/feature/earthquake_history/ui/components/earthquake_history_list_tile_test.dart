// ignore_for_file: scoped_providers_should_specify_dependencies
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/jma_code_table_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_v1_extended.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jma_code_table_types/jma_code_table_types.dart';

void main() async {
  const baseV1 = EarthquakeV1(
    eventId: 20240102235959,
    status: '通常',
  );
  Widget buildWidget(Widget child) => ProviderScope(
        overrides: [
          jmaCodeTableProvider.overrideWithValue(
            JmaCodeTable(
              areaEpicenter: AreaEpicenter(
                items: [
                  AreaEpicenter_AreaEpicenterItem(
                    code: '100',
                    name: '石狩地方北部',
                  ),
                ],
              ),
              areaEpicenterDetail: AreaEpicenterDetail(
                items: [
                  AreaEpicenterDetail_AreaEpicenterDetailItem(
                    code: '1001',
                    name: '米国、アラスカ州中央部',
                  ),
                ],
              ),
            ),
          ),
          intensityColorProvider.overrideWith(_FakeIntensityColor.new),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: child,
          ),
        ),
      );

  testWidgets("遠地地震の場合、'遠地地震'が表示されること(20210121212726)",
      (WidgetTester tester) async {
    // Arrange
    final v1Extended = EarthquakeV1Extended(
      earthquake: baseV1.copyWith(
        headline: '''２１日２１時２３分ころ、海外で規模の大きな地震がありました。''',
      ),
      maxIntensityRegionNames: null,
    );
    // Act
    await tester.pumpWidget(
      buildWidget(
        EarthquakeHistoryListTile(
          item: v1Extended,
        ),
      ),
    );
    // Assert
    expect(find.text('遠地\n地震'), findsOneWidget);
  });
  testWidgets(
    '大規模な噴火の場合、\'大規模な噴火\'が表示されること(20210813033300)',
    (WidgetTester tester) async {
      // Arrange
      final v1Extended = EarthquakeV1Extended(
        earthquake: baseV1.copyWith(
          text: '''
この地震による日本への津波の影響はありません。
令和４年３月８日１８時５０分頃（日本時間）にマナム火山で大規模な噴火が発生しました（ダーウィン航空路火山灰情報センター（ＶＡＡＣ）による）。
（注１）本情報の冒頭に「海外で規模の大きな地震がありました。」や「震源地」とありますが、これは「遠地地震に関する情報」を作成する際に自動的に付与される文言です。実際には、規模の大きな地震は発生していない点に留意してください。
（注２）火山噴火に伴う潮位変化の呼称については、今後検討していきますが、当面は防災対応の呼びかけとして「津波」と表記します。''',
        ),
        maxIntensityRegionNames: null,
      );
      // Act
      await tester.pumpWidget(
        buildWidget(
          EarthquakeHistoryListTile(
            item: v1Extended,
          ),
        ),
      );
      // Assert
      expect(find.text('大規模な噴火'), findsOneWidget);
    },
  );
  group(
    'ListTile.trailing(マグニチュード)',
    () {
      testWidgets(
        'マグニチュードがある場合、マグニチュードが表示されること',
        (WidgetTester tester) async {
          // Arrange
          final v1Extended = EarthquakeV1Extended(
            earthquake: baseV1.copyWith(
              magnitude: 5.1,
            ),
            maxIntensityRegionNames: null,
          );
          // Act
          await tester.pumpWidget(
            buildWidget(
              EarthquakeHistoryListTile(
                item: v1Extended,
              ),
            ),
          );
          // Assert
          final listTile = tester.widget<ListTile>(
            find.byType(ListTile),
          );
          final trailingText = listTile.trailing;
          expect(trailingText, isA<Text>());
          expect(
            (trailingText! as Text).data,
            'M5.1',
          );
        },
      );
      testWidgets(
        'マグニチュードが整数の場合、小数第1位まで表示されること',
        (WidgetTester tester) async {
          // Arrange
          final v1Extended = EarthquakeV1Extended(
            earthquake: baseV1.copyWith(
              magnitude: 5,
            ),
            maxIntensityRegionNames: null,
          );
          // Act
          await tester.pumpWidget(
            buildWidget(
              EarthquakeHistoryListTile(
                item: v1Extended,
              ),
            ),
          );
          // Assert
          final listTile = tester.widget<ListTile>(
            find.byType(ListTile),
          );
          final trailingText = listTile.trailing;
          expect(trailingText, isA<Text>());
          expect(
            (trailingText! as Text).data,
            'M5.0',
          );
        },
      );
      testWidgets(
        'マグニチュードが小数第2位以降ある場合、四捨五入されて小数第1位まで表示されること(繰り下げケース)',
        (WidgetTester tester) async {
          // Arrange
          final v1Extended = EarthquakeV1Extended(
            earthquake: baseV1.copyWith(
              magnitude: 5.123,
            ),
            maxIntensityRegionNames: null,
          );
          // Act
          await tester.pumpWidget(
            buildWidget(
              EarthquakeHistoryListTile(
                item: v1Extended,
              ),
            ),
          );
          // Assert
          final listTile = tester.widget<ListTile>(
            find.byType(ListTile),
          );
          final trailingText = listTile.trailing;
          expect(trailingText, isA<Text>());
          expect(
            (trailingText! as Text).data,
            'M5.1',
          );
        },
      );
      testWidgets(
        'マグニチュードが小数第2位以降ある場合、四捨五入されて小数第1位まで表示されること(繰り上げケース)',
        (WidgetTester tester) async {
          // Arrange
          final v1Extended = EarthquakeV1Extended(
            earthquake: baseV1.copyWith(
              magnitude: 5.162,
            ),
            maxIntensityRegionNames: null,
          );
          // Act
          await tester.pumpWidget(
            buildWidget(
              EarthquakeHistoryListTile(
                item: v1Extended,
              ),
            ),
          );
          // Assert
          final listTile = tester.widget<ListTile>(
            find.byType(ListTile),
          );
          final trailingText = listTile.trailing;
          expect(trailingText, isA<Text>());
          expect(
            (trailingText! as Text).data,
            'M5.2',
          );
        },
      );
    },
  );
  group('ListTileの背景', () {
    testWidgets(
      '背景色塗りつぶし無効の場合、背景色が塗りつぶされないこと',
      (tester) async {
        // Arrange
        final v1Extended = EarthquakeV1Extended(
          earthquake: baseV1.copyWith(
            maxIntensity: JmaIntensity.fiveLower,
          ),
          maxIntensityRegionNames: null,
        );
        // Act
        await tester.pumpWidget(
          buildWidget(
            EarthquakeHistoryListTile(
              item: v1Extended,
              showBackgroundColor: false,
            ),
          ),
        );

        // Assert
        final listTile = tester.widget<ListTile>(
          find.byType(ListTile),
        );
        expect(listTile.tileColor, null);
      },
    );
    group('背景色塗りつぶし有効の場合、背景色が透明度40%で塗りつぶされること', () {
      for (final maxIntensity in JmaIntensity.values) {
        final expectedColor = IntensityColorModel.eqmonitor()
            .fromJmaIntensity(maxIntensity)
            .background
            .withOpacity(0.4);
        testWidgets(
          '最大震度$maxIntensityの場合',
          (tester) async {
            // Arrange
            final v1Extended = EarthquakeV1Extended(
              earthquake: baseV1.copyWith(
                maxIntensity: maxIntensity,
              ),
              maxIntensityRegionNames: null,
            );

            // Act
            await tester.pumpWidget(
              buildWidget(
                EarthquakeHistoryListTile(
                  item: v1Extended,
                ),
              ),
            );

            // Assert
            final listTile = tester.widget<ListTile>(
              find.byType(ListTile),
            );
            expect(listTile.tileColor, expectedColor);
          },
        );
      }
    });
  });
  group(
    'ListTile.title部分',
    () {
      testWidgets('震源地名がある場合、震源地名が表示されること', (tester) async {
        // Arrange
        final v1Extended = EarthquakeV1Extended(
          earthquake: baseV1.copyWith(
            epicenterCode: 100,
          ),
          maxIntensityRegionNames: [],
        );

        // Act
        await tester.pumpWidget(
          buildWidget(
            EarthquakeHistoryListTile(
              item: v1Extended,
            ),
          ),
        );

        // Assert
        expect(find.text('石狩地方北部'), findsOneWidget);
      });
      testWidgets(
        '補助震源地名がある場合、補助震源地名も表示されること',
        (tester) async {
          // Arrange
          final v1Extended = EarthquakeV1Extended(
            earthquake: baseV1.copyWith(
              epicenterCode: 100,
              epicenterDetailCode: 1001,
            ),
            maxIntensityRegionNames: [],
          );

          // Act
          await tester.pumpWidget(
            buildWidget(
              EarthquakeHistoryListTile(
                item: v1Extended,
              ),
            ),
          );

          // Assert
          final listTile = tester.widget<ListTile>(
            find.byType(ListTile),
          );
          final titleText = listTile.title;
          expect(titleText, isA<Text>());
          expect(
            (titleText! as Text).data,
            '石狩地方北部(米国、アラスカ州中央部)',
          );
        },
      );
      testWidgets('震源地名が無いが、最大震度とその観測地域(複数)がある場合、最大震度とその観測地域が表示されること',
          (tester) async {
        // Arrange
        final v1Extended = EarthquakeV1Extended(
          earthquake: baseV1.copyWith(
            epicenterCode: null,
            maxIntensity: JmaIntensity.fiveLower,
          ),
          maxIntensityRegionNames: ['静岡県伊豆', '神奈川県西部'],
        );

        // Act
        await tester.pumpWidget(
          buildWidget(
            EarthquakeHistoryListTile(
              item: v1Extended,
            ),
          ),
        );

        // Assert
        final listTile = tester.widget<ListTile>(
          find.byType(ListTile),
        );
        final titleText = listTile.title;
        expect(titleText, isA<Text>());
        expect(
          (titleText! as Text).data,
          '最大震度5弱を静岡県伊豆などで観測',
        );
      });
      testWidgets('震源地名が無いが、最大震度とその観測地域(1つ)がある場合、最大震度とその観測地域が表示されること',
          (tester) async {
        // Arrange
        final v1Extended = EarthquakeV1Extended(
          earthquake: baseV1.copyWith(
            epicenterCode: null,
            maxIntensity: JmaIntensity.fiveLower,
          ),
          maxIntensityRegionNames: ['静岡県伊豆'],
        );

        // Act
        await tester.pumpWidget(
          buildWidget(
            EarthquakeHistoryListTile(
              item: v1Extended,
            ),
          ),
        );

        // Assert
        final listTile = tester.widget<ListTile>(
          find.byType(ListTile),
        );
        final titleText = listTile.title;
        expect(titleText, isA<Text>());
        expect(
          (titleText! as Text).data,
          '最大震度5弱を静岡県伊豆で観測',
        );
      });
    },
  );
  group(
    'ListTile.subtitle部分',
    () {
      testWidgets(
        '地震発生時刻がある場合、地震発生時刻が表示されること',
        (tester) async {
          // Arrange
          final v1Extended = EarthquakeV1Extended(
            earthquake: baseV1.copyWith(
              eventId: 20240102235959,
              originTime: DateTime(2024, 1, 2, 23, 59, 59),
            ),
            maxIntensityRegionNames: [],
          );

          // Act
          await tester.pumpWidget(
            buildWidget(
              EarthquakeHistoryListTile(
                item: v1Extended,
              ),
            ),
          );

          // Assert
          final listTile = tester.widget<ListTile>(
            find.byType(ListTile),
          );
          final subTitle = listTile.subtitle;
          expect(subTitle, isA<Wrap>());
          final wrap = subTitle! as Wrap;
          // subTitleの文字要素は1つ目である
          expect(wrap.children[0], isA<Text>());
          final text = wrap.children[0] as Text;
          expect(
            text.data,
            startsWith('2024/01/02 23:59頃発生'),
          );
        },
      );
      testWidgets(
        '地震発生時刻がなく、検知時刻がある場合、検知時刻が表示されること',
        (tester) async {
          // Arrange
          final v1Extended = EarthquakeV1Extended(
            earthquake: baseV1.copyWith(
              eventId: 20240102235959,
              arrivalTime: DateTime(2024, 1, 2, 23, 59, 59),
            ),
            maxIntensityRegionNames: [],
          );

          // Act
          await tester.pumpWidget(
            buildWidget(
              EarthquakeHistoryListTile(
                item: v1Extended,
              ),
            ),
          );

          // Assert
          final listTile = tester.widget<ListTile>(
            find.byType(ListTile),
          );
          final subTitle = listTile.subtitle;
          expect(subTitle, isA<Wrap>());
          final wrap = subTitle! as Wrap;
          // subTitleの文字要素は1つ目である
          expect(wrap.children[0], isA<Text>());
          final text = wrap.children[0] as Text;
          expect(
            text.data,
            startsWith('2024/01/02 23:59頃検知'),
          );
        },
      );
      testWidgets(
        "深さ0kmの時、'深さ ごく浅い'が表示されること",
        (tester) async {
          // Arrange
          final v1Extended = EarthquakeV1Extended(
            earthquake: baseV1.copyWith(
              depth: 0,
            ),
            maxIntensityRegionNames: [],
          );

          // Act
          await tester.pumpWidget(
            buildWidget(
              EarthquakeHistoryListTile(
                item: v1Extended,
              ),
            ),
          );

          // Assert
          final listTile = tester.widget<ListTile>(
            find.byType(ListTile),
          );
          final subTitle = listTile.subtitle;
          expect(subTitle, isA<Wrap>());
          final wrap = subTitle! as Wrap;
          // subTitleの文字要素は1つ目である
          expect(wrap.children[0], isA<Text>());
          final text = wrap.children[0] as Text;
          expect(
            text.data,
            endsWith('深さ ごく浅い'),
          );
        },
      );
      testWidgets(
        '深さ10kmの時、深さ 10kmが表示されること',
        (tester) async {
          // Arrange
          final v1Extended = EarthquakeV1Extended(
            earthquake: baseV1.copyWith(
              depth: 10,
            ),
            maxIntensityRegionNames: [],
          );

          // Act
          await tester.pumpWidget(
            buildWidget(
              EarthquakeHistoryListTile(
                item: v1Extended,
              ),
            ),
          );

          // Assert
          final listTile = tester.widget<ListTile>(
            find.byType(ListTile),
          );
          final subTitle = listTile.subtitle;
          expect(subTitle, isA<Wrap>());
          final wrap = subTitle! as Wrap;
          // subTitleの文字要素は1つ目である
          expect(wrap.children[0], isA<Text>());
          final text = wrap.children[0] as Text;
          expect(
            text.data,
            endsWith('深さ 10km'),
          );
        },
      );
      testWidgets(
        '深さ700kmの時、深さ 700km以上が表示されること',
        (tester) async {
          // Arrange
          final v1Extended = EarthquakeV1Extended(
            earthquake: baseV1.copyWith(
              depth: 700,
            ),
            maxIntensityRegionNames: [],
          );

          // Act
          await tester.pumpWidget(
            buildWidget(
              EarthquakeHistoryListTile(
                item: v1Extended,
              ),
            ),
          );

          // Assert
          final listTile = tester.widget<ListTile>(
            find.byType(ListTile),
          );
          final subTitle = listTile.subtitle;
          expect(subTitle, isA<Wrap>());
          final wrap = subTitle! as Wrap;
          // subTitleの文字要素は1つ目である
          expect(wrap.children[0], isA<Text>());
          final text = wrap.children[0] as Text;
          expect(
            text.data,
            endsWith('深さ 700km以上'),
          );
        },
      );
      testWidgets(
        '最大長周期地震動階級が0の場合、Chipが表示されないこと',
        (tester) async {
          // Arrange
          final v1Extended = EarthquakeV1Extended(
            earthquake: baseV1.copyWith(
              maxLpgmIntensity: JmaLgIntensity.zero,
            ),
            maxIntensityRegionNames: [],
          );

          // Act
          await tester.pumpWidget(
            buildWidget(
              EarthquakeHistoryListTile(
                item: v1Extended,
              ),
            ),
          );

          // Assert
          expect(find.byType(Chip), findsNothing);
        },
      );
      group(
        '最大長周期地震動階級が0以外の場合',
        () {
          for (final intensity in [...JmaLgIntensity.values]
            ..remove(JmaLgIntensity.zero)) {
            testWidgets(
              '最大長周期地震動階級が$intensityの場合、Chipとそのラベルが表示されること',
              (tester) async {
                // Arrange
                final v1Extended = EarthquakeV1Extended(
                  earthquake: baseV1.copyWith(
                    maxLpgmIntensity: intensity,
                  ),
                  maxIntensityRegionNames: [],
                );

                // Act
                await tester.pumpWidget(
                  buildWidget(
                    EarthquakeHistoryListTile(
                      item: v1Extended,
                    ),
                  ),
                );

                // Assert
                expect(find.byType(Chip), findsOneWidget);
                final chip = tester.widget<Chip>(
                  find.byType(Chip),
                );
                expect(chip.label, isA<Text>());
                final label = chip.label as Text;
                expect(
                  label.data,
                  '最大長周期地震動階級 $intensity',
                );
              },
            );
          }
        },
      );
    },
  );
  testWidgets('タップ時にonTapが呼ばれること', (tester) async {
    // Arrange
    final v1Extended = EarthquakeV1Extended(
      earthquake: baseV1.copyWith(
        eventId: 20240102235959,
      ),
      maxIntensityRegionNames: [],
    );
    var isTapped = false;
    // Act
    await tester.pumpWidget(
      buildWidget(
        EarthquakeHistoryListTile(
          item: v1Extended,
          onTap: () {
            isTapped = true;
          },
        ),
      ),
    );
    await tester.tap(find.byType(ListTile));
    // Assert
    expect(isTapped, true);
  });
}

class _FakeIntensityColor extends IntensityColor {
  @override
  IntensityColorModel build() => IntensityColorModel.eqmonitor();
}
