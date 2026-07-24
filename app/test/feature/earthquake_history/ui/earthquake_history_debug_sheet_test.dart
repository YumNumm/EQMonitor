import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_debug_override_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_map_layer_parameter_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/nearby_earthquakes_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/modal/earthquake_history_debug_sheet.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/earthquake_history_details_page.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/data/model/map_configuration.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

void main() {
  testWidgets('詳細のdebug sheetでVXSE52を適用しresetできる', (tester) async {
    tester.view.physicalSize = const Size(500, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async => null,
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );
    final originalMapLibrePlatform = MapLibrePlatform.instance;
    MapLibrePlatform.instance = _FakeMapLibrePlatform();
    addTearDown(() => MapLibrePlatform.instance = originalMapLibrePlatform);
    final detailsNotifier = _StubDetailsNotifier(_baseEarthquake);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          earthquakeHistoryDetailsProvider(
            _eventId,
          ).overrideWith(() => detailsNotifier),
          earthquakeHistoryMapLayerParameterProvider.overrideWith(
            _StubMapLayerParameterNotifier.new,
          ),
          homeConfigurationProvider.overrideWith(
            _StubHomeConfigurationNotifier.new,
          ),
          mapConfigurationProvider.overrideWith(
            _StubMapConfigurationNotifier.new,
          ),
          nearbyEarthquakesProvider.overrideWith(
            (ref, query) async => const [],
          ),
        ],
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: [DesignSystemThemeExtension.light()],
          ),
          home: const EarthquakeHistoryDetailsPage(eventId: _eventId),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.bug_report_rounded), findsOneWidget);
    final debugButton = find.ancestor(
      of: find.byIcon(Icons.bug_report_rounded),
      matching: find.byType(InkWell),
    );
    expect(debugButton.hitTestable(), findsOneWidget);
    await tester.tap(debugButton.hitTestable());
    await tester.pumpAndSettle();

    expect(find.text('地震情報'), findsOneWidget);
    expect(find.text('マップレイヤー'), findsOneWidget);

    final hypocenterNameField = find.widgetWithText(TextFormField, '震央名');
    await tester.ensureVisible(hypocenterNameField);
    expect(
      tester.widget<TextFormField>(hypocenterNameField).controller?.text,
      '基準震源',
    );
    await tester.enterText(hypocenterNameField, 'デバッグ震源');
    await tester.pump();
    final applyButton = find.byKey(const Key('vxse-apply-button'));
    await _scrollEditorTo(tester, applyButton);
    await tester.tap(applyButton.hitTestable());
    await tester.pump();
    await tester.tapAt(const Offset(8, 8));
    await tester.pumpAndSettle();

    expect(find.text('デバッグ震源'), findsOneWidget);
    expect(detailsNotifier.buildCount, 1);

    await tester.tap(debugButton.hitTestable());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('earthquake-debug-reset-button')));
    await tester.pump();
    await tester.tapAt(const Offset(8, 8));
    await tester.pumpAndSettle();

    expect(find.text('基準震源'), findsOneWidget);
    expect(find.text('デバッグ震源'), findsNothing);
    expect(detailsNotifier.buildCount, 1);
  });

  testWidgets('広幅ではdialogを使いtext scale 2でもmap layer controlsを表示する', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1000, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          earthquakeHistoryMapLayerParameterProvider.overrideWith(
            _StubMapLayerParameterNotifier.new,
          ),
        ],
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: [DesignSystemThemeExtension.light()],
          ),
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(2)),
            child: child ?? const SizedBox.shrink(),
          ),
          home: Consumer(
            builder: (context, ref, child) => Scaffold(
              body: Center(
                child: FilledButton(
                  onPressed: () => ref
                      .read(earthquakeHistoryDebugSheetActionProvider)
                      .show(context: context, current: _baseEarthquake),
                  child: const Text('開く'),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('開く'));
    await tester.pumpAndSettle();
    expect(find.byType(Dialog), findsOneWidget);
    expect(find.text('地震情報'), findsOneWidget);
    await tester.tap(find.text('マップレイヤー'));
    await tester.pumpAndSettle();
    expect(find.text('レイヤーパラメータ (Debug)'), findsOneWidget);
    expect(find.text('ズーム閾値'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

Future<void> _scrollEditorTo(WidgetTester tester, Finder finder) async {
  final scrollView = find.byKey(const Key('vxse-editor-scroll'));
  for (var attempt = 0; attempt < 30 && finder.evaluate().isEmpty; attempt++) {
    await tester.drag(scrollView, const Offset(0, -240));
    await tester.pump();
  }
  for (
    var attempt = 0;
    attempt < 30 && finder.hitTestable().evaluate().isEmpty;
    attempt++
  ) {
    await tester.drag(scrollView, const Offset(0, -300));
    await tester.pump();
  }
}

const _eventId = 'debug-sheet-event';

final _baseEarthquake = Earthquake(
  eventId: _eventId,
  status: TelegramStatus.normal,
  originTime: DateTime.utc(2026, 7, 24),
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: DateTime.utc(2026, 7, 24, 0, 1),
  dataSources: const [EarthquakeDataSource.jmaDisasterInformationXml],
  telegramTypes: const [EarthquakeTelegramType.vxse52],
  hypocenter: const EarthquakeHypocenter(
    code: '001',
    name: '基準震源',
    coordinates: Coordinate.latLng(latitude: 35, longitude: 139),
    magnitude: EarthquakeMagnitude.value(value: 4.5),
    depth: EarthquakeDepth.value(value: 40),
    detailedCode: null,
    detailedName: null,
  ),
  intensity: null,
  estimatedIntensityTileUrl: null,
);

final class _StubDetailsNotifier extends EarthquakeHistoryDetailsNotifier {
  _StubDetailsNotifier(this.base);

  final Earthquake base;
  var buildCount = 0;

  @override
  Future<Earthquake> build(String eventId) async {
    buildCount++;
    ref.listen(earthquakeDebugOverrideProvider(eventId), (_, override) {
      state = AsyncData(override ?? base);
    });
    return base;
  }
}

final class _StubMapLayerParameterNotifier
    extends EarthquakeHistoryMapLayerParameterNotifier {
  @override
  Future<EarthquakeHistoryMapLayerParameter> build() async =>
      const EarthquakeHistoryMapLayerParameter();
}

final class _StubHomeConfigurationNotifier extends HomeConfigurationNotifier {
  @override
  Future<HomeConfigurationModel> build() async =>
      const HomeConfigurationModel();
}

final class _StubMapConfigurationNotifier extends MapConfigurationNotifier {
  @override
  Future<MapConfiguration> build() async => const MapConfiguration(
    theme: MapTheme.light,
    styleString: '{"version":8,"sources":{},"layers":[]}',
  );
}

final class _FakeMapLibrePlatform extends MapLibrePlatform
    with MockPlatformInterfaceMixin {
  @override
  MapLibreMapState createWidgetState() => _FakeMapLibreMapState();
}

final class _FakeMapLibreMapState extends MapLibreMapState {
  @override
  Widget buildPlatformWidget(BuildContext context) =>
      const SizedBox.expand(child: ColoredBox(color: Colors.transparent));

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
