import 'dart:convert';

import 'package:assets_util/assets_util.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as app_log;
import 'package:eqmonitor/feature/settings/children/config/debug/asset_pack/asset_pack_debug_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/asset_pack/asset_pack_debug_provider.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/asset_pack/asset_pack_debug_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  setUpAll(() {
    app_log.talker = Talker();
  });

  testWidgets('renders unsupported OS evidence for bundled assets', (
    tester,
  ) async {
    await tester.pumpWidget(testApp(info: debugInfo(status: .unsupportedOs)));
    await tester.pumpAndSettle();

    expect(find.text('未対応OS'), findsOneWidget);
    expect(find.text('Version 25.0'), findsOneWidget);
    expect(find.text('platform'), findsAtLeastNWidgets(1));
  });

  testWidgets('renders missing file and native error evidence', (tester) async {
    await tester.pumpWidget(
      testApp(
        info: debugInfo(
          status: .assetMissing,
          nativeError: const AssetPackNativeError(
            domain: 'BAErrorDomain',
            code: 12,
            description: 'Unavailable',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('asset不足'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Unavailable'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('BAErrorDomain'), findsOneWidget);
    expect(find.text('Unavailable'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.textContaining('ファイルなし'),
      300,
      scrollable: find.byType(Scrollable).first,
    );

    expect(find.textContaining('ファイルなし'), findsOneWidget);
    expect(
      find.textContaining('resolved_url: file:///resolved/all.pmtiles'),
      findsOneWidget,
    );
  });

  testWidgets('refresh reloads bundled diagnostics', (tester) async {
    var diagnoses = 0;
    final repository = AssetPackDebugRepository(
      diagnosePack: () async {
        diagnoses += 1;
        return debugInfo(status: .ready).diagnostics;
      },
    );
    await tester.pumpWidget(testApp(repository: repository));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('診断を再読込'));
    await tester.pumpAndSettle();
    expect(diagnoses, 2);
  });

  testWidgets('does not overflow at text scale 2', (tester) async {
    await tester.pumpWidget(
      testApp(info: debugInfo(status: .assetSizeMismatch), textScale: 2),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}

Widget testApp({
  AssetPackDebugInfo? info,
  AssetPackDebugRepository? repository,
  double textScale = 1,
}) {
  final resolvedRepository =
      repository ??
      AssetPackDebugRepository(
        diagnosePack: () async =>
            (info ?? debugInfo(status: .ready)).diagnostics,
      );
  final theme = ThemeData.light().copyWith(
    extensions: [DesignSystemThemeExtension.light()],
  );
  return ProviderScope(
    overrides: [
      assetPackDebugRepositoryProvider.overrideWithValue(resolvedRepository),
      if (info != null)
        assetPackDebugInfoProvider.overrideWith((ref) async => info),
    ],
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

AssetPackDebugInfo debugInfo({
  required AssetPackDiagnosticStatus status,
  AssetPackNativeError? nativeError,
}) {
  final diagnostics = AssetPackDiagnostics.fromJsonString(
    jsonEncode({
      'schema_version': 2,
      'platform': 'ios',
      'os_version': status == AssetPackDiagnosticStatus.unsupportedOs
          ? 'Version 25.0'
          : 'Version 26.4',
      'pack_id': 'platform',
      'status': status.name,
      'system_availability': 'unavailable',
      'detail': 'diagnostic details',
      'manifest_url': 'file:///pack/manifest.json',
      'pack_root': '/pack',
      'manifest': null,
      'assets': status == AssetPackDiagnosticStatus.unsupportedOs
          ? <Map<String, dynamic>>[]
          : [
              {
                'path': 'map/all.pmtiles',
                'status': switch (status) {
                  AssetPackDiagnosticStatus.ready => 'ready',
                  AssetPackDiagnosticStatus.assetSizeMismatch => 'sizeMismatch',
                  _ => 'missing',
                },
                'exists': status != AssetPackDiagnosticStatus.assetMissing,
                'expected_size_bytes': 10,
                'actual_size_bytes':
                    status == AssetPackDiagnosticStatus.assetMissing ? null : 7,
                'resolved_url': 'file:///resolved/all.pmtiles',
                'native_error': null,
              },
            ],
      'native_error': nativeError == null
          ? null
          : {
              'domain': nativeError.domain,
              'code': nativeError.code,
              'description': nativeError.description,
            },
    }),
  );
  return AssetPackDebugInfo(
    diagnostics: diagnostics,
    manifest: null,
    manifestParseError: null,
    assets: diagnostics.assets
        .map(
          (diagnostic) =>
              AssetPackAssetFileStatus(diagnostic: diagnostic, item: null),
        )
        .toList(),
  );
}
