import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_distribution_manifest.dart';
import 'package:eqmonitor/feature/asset_pack/data/notifier/asset_pack_update_notifier.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_update_installer.dart';
import 'package:eqmonitor/feature/asset_pack/ui/component/asset_pack_update_card.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  setUp(() {
    FakeAssetPackUpdateNotifier.installCount = 0;
    FakeAssetPackUpdateNotifier.initialState =
        const AssetPackUpdateAvailableState(
          entry: entry,
          changelogEntries: [entry, previousEntry],
        );
  });

  testWidgets('requires explicit consent before starting the download', (
    tester,
  ) async {
    await pumpUpdateCard(tester: tester);
    await tester.pump();

    expect(find.text('Asset Pack v1.2.3 を利用できます'), findsOneWidget);
    expect(FakeAssetPackUpdateNotifier.installCount, 0);

    await tester.tap(find.text('Asset Pack v1.2.3 を利用できます'));
    await tester.pumpAndSettle();

    expect(find.text('ダウンロード'), findsOneWidget);
    expect(find.text('あとで'), findsOneWidget);
    expect(find.text('v1.2.3 • Map'), findsOneWidget);
    expect(find.text('v1.1.0 • Parameters'), findsOneWidget);
    expect(FakeAssetPackUpdateNotifier.installCount, 0);

    await tester.tap(find.text('ダウンロード'));
    await tester.pumpAndSettle();

    expect(FakeAssetPackUpdateNotifier.installCount, 1);
  });

  testWidgets('shows determinate download progress without overflow', (
    tester,
  ) async {
    FakeAssetPackUpdateNotifier.initialState = const AssetPackUpdateInstalling(
      entry: entry,
      progress: AssetPackInstallProgress(
        phase: AssetPackInstallPhase.downloading,
        progress: 0.42,
      ),
    );

    await pumpUpdateCard(
      tester: tester,
      textScaler: const TextScaler.linear(2),
    );

    expect(find.text('ダウンロード中 42%'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('requires an app update without offering a pack download', (
    tester,
  ) async {
    FakeAssetPackUpdateNotifier.initialState =
        const AssetPackUpdateAppRequiredState(entry: entry);

    await pumpUpdateCard(tester: tester);

    expect(find.text('アプリの更新が必要です'), findsOneWidget);
    expect(find.text('ダウンロード'), findsNothing);
  });

  testWidgets('shows a bounded retry message after a check failure', (
    tester,
  ) async {
    FakeAssetPackUpdateNotifier.initialState = const AssetPackUpdateError(
      message: '現在のデータを使用します。',
      isUpdating: false,
    );

    await pumpUpdateCard(tester: tester);

    expect(find.text('Asset Pack の更新確認に失敗しました'), findsOneWidget);
    expect(find.byTooltip('再試行'), findsOneWidget);
  });
}

class FakeAssetPackUpdateNotifier extends AssetPackUpdateNotifier {
  static var installCount = 0;
  static AssetPackUpdateState initialState = const AssetPackUpdateIdle();

  @override
  AssetPackUpdateState build() => initialState;

  @override
  Future<void> check() async {}

  @override
  Future<void> install({required AssetPackDistributionEntry entry}) async {
    installCount++;
  }
}

Future<void> pumpUpdateCard({
  required WidgetTester tester,
  TextScaler textScaler = TextScaler.noScaling,
}) => tester.pumpWidget(
  ProviderScope(
    overrides: [
      assetPackUpdateProvider.overrideWith(FakeAssetPackUpdateNotifier.new),
    ],
    child: MaterialApp(
      locale: const Locale('ja'),
      theme: ThemeData.light().copyWith(
        extensions: [DesignSystemThemeExtension.light()],
      ),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: textScaler),
        child: child ?? const SizedBox.shrink(),
      ),
      home: const Scaffold(body: AssetPackUpdateCard()),
    ),
  ),
);

const entry = AssetPackDistributionEntry(
  version: '1.2.3',
  publishedAt: '2026-08-16',
  minimumAppVersion: '3.0.0',
  archivePath: 'packs/1.2.3/asset-pack-v1.2.3.zip',
  archiveSizeBytes: 10 * 1024 * 1024,
  archiveSha256:
      'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
  localizations: {
    'ja': AssetPackChangelogLocalization(
      sections: [
        AssetPackChangelogSection(title: '地図', items: ['地図データを更新しました']),
      ],
    ),
    'en': AssetPackChangelogLocalization(
      sections: [
        AssetPackChangelogSection(title: 'Map', items: ['Updated map data']),
      ],
    ),
  },
);

const previousEntry = AssetPackDistributionEntry(
  version: '1.1.0',
  publishedAt: '2026-08-01',
  minimumAppVersion: '3.0.0',
  archivePath: 'packs/1.1.0/asset-pack-v1.1.0.zip',
  archiveSizeBytes: 8 * 1024 * 1024,
  archiveSha256:
      'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb',
  localizations: {
    'ja': AssetPackChangelogLocalization(
      sections: [
        AssetPackChangelogSection(title: 'パラメータ', items: ['地域データを更新しました']),
      ],
    ),
    'en': AssetPackChangelogLocalization(
      sections: [
        AssetPackChangelogSection(
          title: 'Parameters',
          items: ['Updated regional data'],
        ),
      ],
    ),
  },
);
