import 'dart:async';

import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/api/cache_only_api_client_provider.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_apply_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft_factory.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_debug_override_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_map_layer_parameter_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/nearby_earthquakes_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_details_map_view.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/modal/earthquake_history_debug_modal.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/modal/earthquake_history_debug_sheet.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/earthquake_history_details_page.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/data/model/map_configuration.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/parameter/data/model/shindo_db/shindo_db_stations_parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
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
    final fixture = _productionFixture();
    addTearDown(fixture.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: fixture.container,
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
    fixture.realtimeController.add(
      RealtimeEvent.earthquakeUpsert(
        record: _realtimeEarthquake,
        source: RealtimeSource.eqmonitor,
      ),
    );
    await fixture.container.pump();
    await tester.pump();
    expect(
      tester.widget<TextFormField>(hypocenterNameField).controller?.text,
      'デバッグ震源',
    );
    final applyButton = find.byKey(const Key('vxse-apply-button'));
    await _scrollEditorTo(tester, applyButton);
    await tester.tap(applyButton.hitTestable());
    await tester.pump();
    await tester.tapAt(const Offset(8, 8));
    await tester.pumpAndSettle();

    expect(find.text('デバッグ震源'), findsOneWidget);
    final applied = fixture.container
        .read(earthquakeHistoryDetailsProvider(_eventId))
        .requireValue;
    expect(applied.earthquakeType, EarthquakeType.distant);
    expect(applied.telegramTypes, contains(EarthquakeTelegramType.vxse53));
    expect(fixture.repository.detailFetchCount, 1);

    await tester.tap(debugButton.hitTestable());
    await tester.pumpAndSettle();
    await tester.tap(find.text('地震情報をリセット'));
    await tester.pump();
    await tester.tapAt(const Offset(8, 8));
    await tester.pumpAndSettle();

    expect(find.text('デバッグ震源'), findsNothing);
    final reset = fixture.container
        .read(earthquakeHistoryDetailsProvider(_eventId))
        .requireValue;
    expect(reset.earthquakeType, EarthquakeType.distant);
    expect(reset.telegramTypes, contains(EarthquakeTelegramType.vxse53));
    expect(fixture.repository.detailFetchCount, 1);

    await tester.tap(debugButton.hitTestable());
    await tester.pumpAndSettle();
    expect(find.text('VXSE53'), findsOneWidget);
  });

  for (final textScale in [1.0, 2.0]) {
    testWidgets('幅320 scale $textScale のmap tabでresetを表示・実行できる', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final layerNotifier = _TrackingMapLayerParameterNotifier();
      final container = ProviderContainer(
        overrides: [
          earthquakeHistoryDetailsProvider(
            _eventId,
          ).overrideWith(() => _ReadyDetailsNotifier(_baseEarthquake)),
          earthquakeHistoryMapLayerParameterProvider.overrideWith(
            () => layerNotifier,
          ),
        ],
      );
      addTearDown(container.dispose);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: ThemeData.light().copyWith(
              extensions: [DesignSystemThemeExtension.light()],
            ),
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(textScale),
              ),
              child: child ?? const SizedBox.shrink(),
            ),
            home: Consumer(
              builder: (context, ref, child) => Scaffold(
                body: FilledButton(
                  onPressed: () => ref
                      .read(earthquakeHistoryDebugSheetActionProvider)
                      .show(context: context, eventId: _eventId),
                  child: const Text('開く'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('開く'));
      await tester.pumpAndSettle();
      expect(find.byType(Dialog), findsNothing);
      await tester.tap(find.text('マップレイヤー'));
      await tester.pumpAndSettle();
      final resetButton = find.text('レイヤー設定をリセット');
      expect(resetButton, findsOneWidget);
      expect(resetButton.hitTestable(), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.tap(resetButton.hitTestable());
      await tester.pump();
      expect(layerNotifier.resetCount, 1);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('広幅ではdialogを使いtext scale 2でもmap layer controlsを表示する', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1000, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final layerNotifier = _TrackingMapLayerParameterNotifier();
    final container = ProviderContainer(
      overrides: [
        earthquakeHistoryDetailsProvider(
          _eventId,
        ).overrideWith(() => _ReadyDetailsNotifier(_baseEarthquake)),
        earthquakeHistoryMapLayerParameterProvider.overrideWith(
          () => layerNotifier,
        ),
      ],
    );
    addTearDown(container.dispose);
    final overrideSubscription = container.listen(
      earthquakeDebugOverrideProvider(_eventId),
      (_, _) {},
    );
    addTearDown(overrideSubscription.close);
    final draft = const EarthquakeVxseDebugDraftFactory().create(
      current: _baseEarthquake,
      type: EarthquakeTelegramType.vxse52,
    );
    container
        .read(earthquakeDebugOverrideProvider(_eventId).notifier)
        .applyDraft(
          current: _baseEarthquake,
          draft: draft,
          mode: EarthquakeVxseApplyMode.merge,
        );
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
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
                      .show(context: context, eventId: _eventId),
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
    expect(find.text('レイヤー設定をリセット'), findsOneWidget);
    expect(find.text('地震情報をリセット'), findsNothing);
    await tester.tap(find.text('レイヤー設定をリセット'));
    await tester.pump();
    expect(layerNotifier.resetCount, 1);
    expect(
      container.read(earthquakeDebugOverrideProvider(_eventId)),
      isNotNull,
    );
    await tester.tap(find.text('地震情報'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('地震情報をリセット'));
    await tester.pump();
    expect(container.read(earthquakeDebugOverrideProvider(_eventId)), isNull);
    expect(layerNotifier.resetCount, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('detailsのloadingとerrorを安全に表示する', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        key: const ValueKey('details-loading'),
        retry: (_, _) => null,
        overrides: [
          earthquakeHistoryDetailsProvider(
            _eventId,
          ).overrideWith(_LoadingDetailsNotifier.new),
        ],
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: [DesignSystemThemeExtension.light()],
          ),
          home: const Scaffold(
            body: SizedBox(
              height: 600,
              child: EarthquakeHistoryDebugSheet(eventId: _eventId),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpWidget(
      ProviderScope(
        key: const ValueKey('details-error'),
        retry: (_, _) => null,
        overrides: [
          earthquakeHistoryDetailsProvider(
            _eventId,
          ).overrideWith(_ErrorDetailsNotifier.new),
        ],
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: [DesignSystemThemeExtension.light()],
          ),
          home: const Scaffold(
            body: SizedBox(
              height: 600,
              child: EarthquakeHistoryDebugSheet(eventId: _eventId),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
    expect(find.text('地震情報を読み込めませんでした'), findsOneWidget);
    expect(find.textContaining('details failed'), findsNothing);
  });

  testWidgets('details更新中やerrorでもlast dataをeditorへ渡す', (tester) async {
    final notifier = _MutableDetailsNotifier(_baseEarthquake);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          earthquakeHistoryDetailsProvider(
            _eventId,
          ).overrideWith(() => notifier),
        ],
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: [DesignSystemThemeExtension.light()],
          ),
          home: const Scaffold(
            body: SizedBox(
              height: 600,
              child: EarthquakeHistoryDebugSheet(eventId: _eventId),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('地震情報'), findsOneWidget);

    notifier.showLoadingWithPrevious();
    await tester.pump();
    expect(find.text('地震情報'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    notifier.showErrorWithPrevious();
    await tester.pump();
    expect(find.text('地震情報'), findsOneWidget);
    expect(find.text('地震情報を読み込めませんでした'), findsNothing);
  });

  testWidgets('map layerのloadingとerrorを安全に表示する', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        key: const ValueKey('map-loading'),
        retry: (_, _) => null,
        overrides: [
          earthquakeHistoryMapLayerParameterProvider.overrideWith(
            _LoadingMapLayerParameterNotifier.new,
          ),
        ],
        child: const MaterialApp(
          home: Scaffold(body: EarthquakeHistoryDebugModal()),
        ),
      ),
    );
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpWidget(
      ProviderScope(
        key: const ValueKey('map-error'),
        retry: (_, _) => null,
        overrides: [
          earthquakeHistoryMapLayerParameterProvider.overrideWith(
            _ErrorMapLayerParameterNotifier.new,
          ),
        ],
        child: const MaterialApp(
          home: Scaffold(body: EarthquakeHistoryDebugModal()),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
    expect(find.text('レイヤー設定を読み込めませんでした'), findsOneWidget);
    expect(find.textContaining('map failed'), findsNothing);
  });

  test('release相当ではdebug設定が明示的にtrueの時だけ表示する', () {
    expect(
      shouldShowEarthquakeHistoryDebugger(
        isDebugBuild: false,
        debugPreference: const AsyncData(false),
      ),
      isFalse,
    );
    expect(
      shouldShowEarthquakeHistoryDebugger(
        isDebugBuild: false,
        debugPreference: const AsyncLoading(),
      ),
      isFalse,
    );
    expect(
      shouldShowEarthquakeHistoryDebugger(
        isDebugBuild: false,
        debugPreference: AsyncError(StateError('failed'), StackTrace.empty),
      ),
      isFalse,
    );
    expect(
      shouldShowEarthquakeHistoryDebugger(
        isDebugBuild: false,
        debugPreference: const AsyncData(true),
      ),
      isTrue,
    );
    expect(
      shouldShowEarthquakeHistoryDebugger(
        isDebugBuild: true,
        debugPreference: const AsyncLoading(),
      ),
      isTrue,
    );
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

final class _ReadyDetailsNotifier extends EarthquakeHistoryDetailsNotifier {
  _ReadyDetailsNotifier(this.base);

  final Earthquake base;

  @override
  Future<Earthquake> build(String eventId) async => base;
}

final class _LoadingDetailsNotifier extends EarthquakeHistoryDetailsNotifier {
  @override
  Future<Earthquake> build(String eventId) => Completer<Earthquake>().future;
}

final class _ErrorDetailsNotifier extends EarthquakeHistoryDetailsNotifier {
  @override
  Future<Earthquake> build(String eventId) =>
      Future.error(StateError('details failed'));
}

final class _MutableDetailsNotifier extends EarthquakeHistoryDetailsNotifier {
  _MutableDetailsNotifier(this.base);

  final Earthquake base;
  Completer<Earthquake>? _refresh;

  @override
  Future<Earthquake> build(String eventId) async => _refresh?.future ?? base;

  void showLoadingWithPrevious() {
    _refresh = Completer<Earthquake>();
    ref.invalidateSelf();
  }

  void showErrorWithPrevious() {
    _refresh?.completeError(StateError('refresh failed'));
  }
}

final class _TrackingMapLayerParameterNotifier
    extends EarthquakeHistoryMapLayerParameterNotifier {
  var resetCount = 0;

  @override
  Future<EarthquakeHistoryMapLayerParameter> build() async =>
      const EarthquakeHistoryMapLayerParameter();

  @override
  Future<void> reset() async {
    resetCount++;
    state = const AsyncData(EarthquakeHistoryMapLayerParameter());
  }
}

final class _LoadingMapLayerParameterNotifier
    extends EarthquakeHistoryMapLayerParameterNotifier {
  @override
  Future<EarthquakeHistoryMapLayerParameter> build() =>
      Completer<EarthquakeHistoryMapLayerParameter>().future;
}

final class _ErrorMapLayerParameterNotifier
    extends EarthquakeHistoryMapLayerParameterNotifier {
  @override
  Future<EarthquakeHistoryMapLayerParameter> build() =>
      Future.error(StateError('map failed'));
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

final class _ProductionFixture {
  const _ProductionFixture({
    required this.container,
    required this.repository,
    required this.realtimeController,
  });

  final ProviderContainer container;
  final _SpyRepository repository;
  final StreamController<RealtimeEvent> realtimeController;

  Future<void> dispose() async {
    container.dispose();
    await realtimeController.close();
  }
}

_ProductionFixture _productionFixture() {
  final realtimeController = StreamController<RealtimeEvent>.broadcast(
    sync: true,
  );
  final cacheClient = api.ApiClient(Dio());
  final repository = _SpyRepository(
    initial: _baseEarthquake,
    cacheClient: cacheClient,
  );
  final container = ProviderContainer(
    overrides: [
      realtimeEventsProvider.overrideWith(
        () => _StubRealtimeEvents(realtimeController.stream),
      ),
      earthquakeHistoryRepositoryProvider.overrideWith(
        (ref) async => repository,
      ),
      cacheOnlyApiClientProvider.overrideWith((ref) async => cacheClient),
      apiClientProvider.overrideWith((ref) async => api.ApiClient(Dio())),
      earthquakeHistoryMapLayerParameterProvider.overrideWith(
        _TrackingMapLayerParameterNotifier.new,
      ),
      homeConfigurationProvider.overrideWith(
        _StubHomeConfigurationNotifier.new,
      ),
      mapConfigurationProvider.overrideWith(_StubMapConfigurationNotifier.new),
      nearbyEarthquakesProvider.overrideWith((ref, query) async => const []),
    ],
  );
  return _ProductionFixture(
    container: container,
    repository: repository,
    realtimeController: realtimeController,
  );
}

final class _StubRealtimeEvents extends RealtimeEvents {
  _StubRealtimeEvents(this.stream);

  final Stream<RealtimeEvent> stream;

  @override
  Stream<RealtimeEvent> build() => stream;
}

final class _SpyRepository extends EarthquakeHistoryRepository {
  _SpyRepository({required this.initial, required this.cacheClient})
    : super(
        earthquake: api.ApiClient(Dio()).earthquake,
        earthquakeParameter: _earthquakeParameter,
        shindoDbStations: _shindoDbStations,
      );

  final Earthquake initial;
  final api.ApiClient cacheClient;
  var detailFetchCount = 0;

  @override
  Future<Earthquake> fetchEarthquakeDetail({
    required String eventId,
    api.ApiClient? client,
  }) async {
    if (identical(client, cacheClient)) {
      throw const CacheMissException();
    }
    detailFetchCount++;
    return initial;
  }
}

final _realtimeEarthquake = api.Earthquake(
  eventId: _eventId,
  status: api.TelegramStatus.normal,
  earthquakeType: api.EarthquakeType.distant,
  originTimePrecision: api.OriginTimePrecision.second,
  datasources: const [api.EarthquakeDatasource.jmaDisasterInformationXml],
  telegrams: [
    api.EarthquakeTelegram(
      telegram: api.Telegram(
        id: 'telegram-realtime',
        eventId: _eventId,
        type: api.TelegramType.vxse53,
        title: '震源・震度情報',
        status: api.TelegramStatus.normal,
        infoType: api.InfoType.publication,
        editorialOffice: '気象庁本庁',
        publishingOffice: const ['気象庁'],
        pressedAt: DateTime.utc(2026, 7, 24, 1),
        reportedAt: DateTime.utc(2026, 7, 24, 1),
        infoKind: '地震情報',
        infoKindVersion: '1.0_0',
        hash: 'hash-realtime',
        createdAt: DateTime.utc(2026, 7, 24, 1),
      ),
      comments: const api.TelegramComments(additional: 'new-realtime'),
    ),
  ],
);

const _parameterMetadata = ParameterMetadata(
  type: ParameterType.jmaCodeTable,
  schemaVersion: 1,
  sourceVersion: 'test',
  sourceUpdatedAt: null,
  sourceUrls: [],
  sha256: 'test',
);
const _earthquakeParameter = EarthquakeParameter(
  metadata: _parameterMetadata,
  prefectures: [],
);
const _shindoDbStations = ShindoDbStationsParameter(
  metadata: ParameterMetadata(
    type: ParameterType.shindoDbStations,
    schemaVersion: 1,
    sourceVersion: 'test',
    sourceUpdatedAt: null,
    sourceUrls: [],
    sha256: 'test',
  ),
  stations: [],
);
