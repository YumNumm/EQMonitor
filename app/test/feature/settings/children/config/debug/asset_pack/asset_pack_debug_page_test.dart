import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as app_log;
import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_diagnostics.dart';
import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_manifest.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_storage_repository.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/asset_pack/asset_pack_debug_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/asset_pack/asset_pack_debug_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  setUpAll(() {
    app_log.talker = Talker();
  });

  testWidgets('renders evidence for the bundled pack', (tester) async {
    await tester.pumpWidget(
      testApp(diagnostics: diagnosticsFor(sourceKind: .bundled)),
    );
    await tester.pumpAndSettle();

    expect(find.text('アプリ同梱Pack'), findsOneWidget);
    expect(find.text('1.2.3'), findsOneWidget);
    expect(find.text('/packs/1.2.3'), findsOneWidget);
    expect(find.text('/bundled/1.2.3'), findsOneWidget);
    expect(find.text('baseMapPmtiles'), findsOneWidget);
  });

  testWidgets('renders evidence for a downloaded pack', (tester) async {
    await tester.pumpWidget(
      testApp(diagnostics: diagnosticsFor(sourceKind: .downloaded)),
    );
    await tester.pumpAndSettle();

    expect(find.text('ダウンロード済みPack'), findsOneWidget);
  });

  testWidgets('renders the failure when the pack cannot be resolved', (
    tester,
  ) async {
    await tester.pumpWidget(
      testApp(loadDiagnostics: () async => throw StateError('boom')),
    );
    await tester.pumpAndSettle();

    expect(find.text('診断の取得に失敗'), findsOneWidget);
  });

  testWidgets('refresh reloads diagnostics', (tester) async {
    var diagnoses = 0;
    await tester.pumpWidget(
      testApp(
        loadDiagnostics: () async {
          diagnoses += 1;
          return diagnosticsFor(sourceKind: .bundled);
        },
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('診断を再読込'));
    await tester.pumpAndSettle();
    expect(diagnoses, 2);
  });

  testWidgets('does not overflow at text scale 2', (tester) async {
    await tester.pumpWidget(
      testApp(
        diagnostics: diagnosticsFor(sourceKind: .downloaded),
        textScale: 2,
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}

Widget testApp({
  AssetPackDiagnostics? diagnostics,
  Future<AssetPackDiagnostics> Function()? loadDiagnostics,
  double textScale = 1,
}) {
  final load =
      loadDiagnostics ??
      () async => diagnostics ?? diagnosticsFor(sourceKind: .bundled);
  final theme = ThemeData.light().copyWith(
    extensions: [DesignSystemThemeExtension.light()],
  );
  return ProviderScope(
    overrides: [assetPackDiagnosticsProvider.overrideWith((ref) => load())],
    child: MaterialApp(
      theme: theme,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(textScaler: TextScaler.linear(textScale)),
        child: child ?? const SizedBox.shrink(),
      ),
      home: const AssetPackDebugPage(),
    ),
  );
}

AssetPackDiagnostics diagnosticsFor({
  required AssetPackSourceKind sourceKind,
}) => AssetPackDiagnostics(
  sourceKind: sourceKind,
  rootPath: '/packs/1.2.3',
  bundledRootPath: '/bundled/1.2.3',
  manifest: AssetPackManifest.fromJson({
    'pack_version': '1.2.3',
    'schema_version': 1,
    'generated_at': '2026-08-19T00:00:00Z',
    'assets': [
      {
        'id': 'BASE_MAP_PMTILES',
        'kind': 'pmtiles',
        'path': 'map/all.pmtiles',
        'schema_version': 1,
        'source_version': '2026-08-01',
        'source_updated_at': '2026-08-01T00:00:00Z',
        'source_urls': <String>[],
        'sha256': 'a' * 64,
        'size_bytes': 1024,
      },
    ],
  }),
);
