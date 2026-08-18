import 'dart:convert';

import 'package:assets_util/assets_util.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as app_log;
import 'package:eqmonitor/feature/settings/children/config/debug/asset_pack/asset_pack_debug_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/asset_pack/asset_pack_debug_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  setUpAll(() {
    app_log.talker = Talker();
  });

  testWidgets('renders evidence for a bundled pack that is ready', (
    tester,
  ) async {
    await tester.pumpWidget(
      testApp(diagnostics: diagnosticsFor(status: .ready)),
    );
    await tester.pumpAndSettle();

    expect(find.text('利用可能'), findsOneWidget);
    expect(find.text('Version 26.4'), findsOneWidget);
    expect(find.text('platform'), findsAtLeastNWidgets(1));
    expect(find.text('/pack'), findsOneWidget);
  });

  testWidgets('renders evidence for a missing bundled manifest', (
    tester,
  ) async {
    await tester.pumpWidget(
      testApp(diagnostics: diagnosticsFor(status: .manifestMissing)),
    );
    await tester.pumpAndSettle();

    expect(find.text('manifestなし'), findsOneWidget);
    expect(find.text('diagnostic details'), findsOneWidget);
  });

  testWidgets('renders the failure when native diagnostics throw', (
    tester,
  ) async {
    await tester.pumpWidget(
      testApp(loadDiagnostics: () async => throw StateError('boom')),
    );
    await tester.pumpAndSettle();

    expect(find.text('診断の取得に失敗'), findsOneWidget);
  });

  testWidgets('refresh reloads bundled diagnostics', (tester) async {
    var diagnoses = 0;
    await tester.pumpWidget(
      testApp(
        loadDiagnostics: () async {
          diagnoses += 1;
          return diagnosticsFor(status: .ready);
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
        diagnostics: diagnosticsFor(status: .manifestMissing),
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
      () async => diagnostics ?? diagnosticsFor(status: .ready);
  final theme = ThemeData.light().copyWith(
    extensions: [DesignSystemThemeExtension.light()],
  );
  return ProviderScope(
    overrides: [
      assetPackDiagnosticsProvider.overrideWith((ref) => load()),
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

AssetPackDiagnostics diagnosticsFor({
  required AssetPackDiagnosticStatus status,
}) => AssetPackDiagnostics.fromJsonString(
  jsonEncode({
    'schema_version': 3,
    'platform': 'ios',
    'os_version': 'Version 26.4',
    'pack_id': 'platform',
    'status': status.name,
    'detail': 'diagnostic details',
    'pack_root': status == AssetPackDiagnosticStatus.ready ? '/pack' : null,
  }),
);
