import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:version/version.dart';

part 'asset_pack_distribution_manifest.freezed.dart';
part 'asset_pack_distribution_manifest.g.dart';

/// R2 で配信される署名付き配信マニフェスト（`manifest.json`）。
/// backend の Valibot スキーマ
/// (`backend/packages/types/src/asset-pack-distribution.ts`) に対応する。
///
/// JSON の構造・型解析は json_serializable が行う。SemVer / SHA-256 の形式や
/// `packs` の並び順といった値の制約は
/// `AssetPackDistributionManifestValidator` が検証するため、このモデル単体を
/// 署名検証済みデータとして信頼してはならない。
@freezed
abstract class AssetPackDistributionManifest
    with _$AssetPackDistributionManifest {
  const factory({
    required int schemaVersion,
    required int revision,
    required String latestVersion,
    required String generatedAt,
    required List<AssetPackDistributionEntry> packs,
  }) = _AssetPackDistributionManifest;

  factory fromJson(Map<String, dynamic> json) =>
      _$AssetPackDistributionManifestFromJson(json);
}

/// [AssetPackDistributionManifest.packs] の 1 要素。
@freezed
abstract class AssetPackDistributionEntry with _$AssetPackDistributionEntry {
  const factory({
    required String version,
    required String publishedAt,
    required String minimumAppVersion,
    required String archivePath,
    required int archiveSizeBytes,
    required String archiveSha256,
    required AssetPackChangelogLocalizations localizations,
  }) = _AssetPackDistributionEntry;

  factory fromJson(Map<String, dynamic> json) =>
      _$AssetPackDistributionEntryFromJson(json);
}

/// 配信元が必ず日本語・英語の両方を含める前提のため、言語ごとの Map ではなく
/// 必須フィールドとして持つ。欠落は json_serializable の解析時点で失敗する。
@freezed
abstract class AssetPackChangelogLocalizations
    with _$AssetPackChangelogLocalizations {
  const factory({
    required AssetPackChangelogLocalization ja,
    required AssetPackChangelogLocalization en,
  }) = _AssetPackChangelogLocalizations;

  factory fromJson(Map<String, dynamic> json) =>
      _$AssetPackChangelogLocalizationsFromJson(json);
}

@freezed
abstract class AssetPackChangelogLocalization
    with _$AssetPackChangelogLocalization {
  const factory({
    required List<AssetPackChangelogSection> sections,
  }) = _AssetPackChangelogLocalization;

  factory fromJson(Map<String, dynamic> json) =>
      _$AssetPackChangelogLocalizationFromJson(json);
}

@freezed
abstract class AssetPackChangelogSection with _$AssetPackChangelogSection {
  const factory({
    required String title,
    required List<String> items,
  }) = _AssetPackChangelogSection;

  factory fromJson(Map<String, dynamic> json) =>
      _$AssetPackChangelogSectionFromJson(json);
}

extension AssetPackDistributionManifestX on AssetPackDistributionManifest {
  /// 有効な Pack のバージョン [version] より新しい配信エントリを、
  /// マニフェストの並び（新しい順）のまま返す。
  ///
  /// [version] が SemVer として解釈できない場合は [Version.parse] が
  /// [FormatException] を投げる。
  List<AssetPackDistributionEntry> entriesNewerThan(String version) {
    final activeVersion = Version.parse(version);
    return packs
        .where((entry) => Version.parse(entry.version) > activeVersion)
        .toList(growable: false);
  }
}

extension AssetPackDistributionEntryX on AssetPackDistributionEntry {
  /// [languageCode] に対応する変更履歴。日本語以外は英語を表示する。
  AssetPackChangelogLocalization localization({required String languageCode}) =>
      languageCode == 'ja' ? localizations.ja : localizations.en;
}
