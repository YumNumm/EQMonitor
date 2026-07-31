import 'dart:convert';

import 'package:assets_util/assets_util.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as app_log;
import 'package:eqmonitor/feature/settings/children/config/debug/asset_pack/asset_pack_debug_action.dart';
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

  testWidgets('success invalidates diagnostics only after explicit execution', (
    tester,
  ) async {
    var diagnoses = 0;
    var updateChecks = 0;
    final repository = AssetPackDebugRepository(
      diagnosePack: () {
        diagnoses += 1;
        return diagnostics();
      },
      checkForUpdates: () async {
        updateChecks += 1;
        return updateResult(success: true);
      },
    );
    await tester.pumpWidget(actionTestApp(repository));
    await tester.pumpAndSettle();

    expect(diagnoses, 1);
    expect(updateChecks, 0);
    await tester.tap(find.text('execute'));
    await tester.pumpAndSettle();

    expect(updateChecks, 1);
    expect(diagnoses, 2);
    expect(find.text('success'), findsOneWidget);
  });

  testWidgets('failure preserves diagnostics and exposes native error', (
    tester,
  ) async {
    var diagnoses = 0;
    final repository = AssetPackDebugRepository(
      diagnosePack: () {
        diagnoses += 1;
        return diagnostics();
      },
      checkForUpdates: () async => updateResult(success: false),
    );
    await tester.pumpWidget(actionTestApp(repository));
    await tester.pumpAndSettle();

    await tester.tap(find.text('execute'));
    await tester.pumpAndSettle();

    expect(diagnoses, 1);
    expect(find.text('Network unavailable'), findsOneWidget);
  });

  testWidgets('unexpected native failure is handled without reloading', (
    tester,
  ) async {
    var diagnoses = 0;
    final repository = AssetPackDebugRepository(
      diagnosePack: () {
        diagnoses += 1;
        return diagnostics();
      },
      checkForUpdates: () async => throw StateError('bridge unavailable'),
    );
    await tester.pumpWidget(actionTestApp(repository));
    await tester.pumpAndSettle();

    await tester.tap(find.text('execute'));
    await tester.pumpAndSettle();

    expect(diagnoses, 1);
    expect(find.textContaining('bridge unavailable'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

Widget actionTestApp(AssetPackDebugRepository repository) => ProviderScope(
  overrides: [assetPackDebugRepositoryProvider.overrideWithValue(repository)],
  child: const MaterialApp(home: Scaffold(body: _ActionHarness())),
);

class _ActionHarness extends ConsumerWidget {
  const _ActionHarness();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diagnostics = ref.watch(assetPackDebugInfoProvider);
    final updateResult = ref.watch(assetPackLastUpdateResultProvider);
    return Column(
      children: [
        Text(diagnostics.hasValue ? 'diagnosed' : 'loading'),
        Text(
          updateResult?.nativeError?.description ??
              (updateResult?.success ?? false ? 'success' : 'none'),
        ),
        FilledButton(
          onPressed: () async => ref
              .read(assetPackDebugActionProvider)
              .checkForUpdates(ref, context),
          child: const Text('execute'),
        ),
      ],
    );
  }
}

AssetPackDiagnostics diagnostics() => AssetPackDiagnostics.fromJsonString(
  jsonEncode({
    'schema_version': 1,
    'platform': 'ios',
    'os_version': 'Version 26.4',
    'pack_id': 'eqmonitor-assets',
    'status': 'manifestMissing',
    'system_availability': 'unavailable',
    'detail': 'missing',
    'manifest_url': 'file:///pack/manifest.json',
    'pack_root': '/pack',
    'manifest': null,
    'assets': <Map<String, dynamic>>[],
    'native_error': null,
  }),
);

AssetPackUpdateResult updateResult({required bool success}) =>
    AssetPackUpdateResult.fromJsonString(
      jsonEncode({
        'schema_version': 1,
        'pack_id': 'eqmonitor-assets',
        'success': success,
        'checked_at': '2026-07-31T00:00:00Z',
        'updating_ids': <String>[],
        'removed_ids': <String>[],
        'native_error': success
            ? null
            : {
                'domain': 'BAErrorDomain',
                'code': 4,
                'description': 'Network unavailable',
              },
      }),
    );
