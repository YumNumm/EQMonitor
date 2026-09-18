import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_distribution_manifest.dart';

/// 変更履歴の内容を検証しないテスト向けの最小限の localizations。
const assetPackChangelogLocalizationsFixture = AssetPackChangelogLocalizations(
  ja: AssetPackChangelogLocalization(
    sections: [
      AssetPackChangelogSection(title: '更新', items: ['地図データを更新しました']),
    ],
  ),
  en: AssetPackChangelogLocalization(
    sections: [
      AssetPackChangelogSection(title: 'Changes', items: ['Updated map data']),
    ],
  ),
);
