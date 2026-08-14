import 'package:freezed_annotation/freezed_annotation.dart';

part 'verified_pm_tiles_source.freezed.dart';

final _sha256Hex = RegExp(r'^[0-9a-fA-F]{64}$');

/// appが検証済みのPMTiles archive(local file / remote URL)をpackageへ渡す
/// ための sealed marker。`BaseMapTileRepository`は本型で local/remote を
/// 網羅的に判別する。sealedのため subtype は本 library(このファイルと
/// 生成 part)に閉じている。
sealed class VerifiedTileSource {
  const VerifiedTileSource();

  /// archiveの実体を区別する識別子。同一URL/pathでも中身が更新された別の
  /// downloadを別物として扱うために使う。
  String get sourceInstanceId;

  /// 検証済み archive の内容 digest(64桁hex)。
  String get sha256;
}

/// tile cache の key に使う、**内容で決まる** source identity。
///
/// cache は`(identity, CanonicalTileId)`で引くため、identity が
/// [VerifiedTileSource.sourceInstanceId]だけだと、source が
/// `sourceInstanceId`を据え置いたまま中身(revision)を差し替えた場合に
/// **exact lookup が前 revision の geometry を返してしまう**
/// (fallback policy はexact hitの後段なので hazard の fail closed も効かない)。
///
/// [VerifiedTileSource.sha256]は内容の digest なので、中身が変われば必ず
/// identity も変わる。revision 番号を key に混ぜるより強い保証になる
/// (revision だけ上がって内容が同じなら cache を共有してよく、内容が変われば
/// revision 据え置きでも別 key になる)。
extension VerifiedTileSourceCacheIdentity on VerifiedTileSource {
  String get cacheIdentity => '$sourceInstanceId@$sha256';
}

/// appが検証済みのPMTiles archiveをpackageへ渡すための契約。
///
/// `eqmonitor_map`は`app`に依存せず、Asset Pack APIやmanifestも知らない
/// (Global Constraints参照)。そのため、絶対path・サイズ・digestの正しさは
/// **呼び出し側(app)が既に検証済みである**ことを前提とし、この値をpackage側
/// では再検証しない。`BaseMapTileRepository`は[absolutePath]をそのまま
/// ファイルとして開くだけで、[sizeBytes]/[sha256]を実ファイルと突き合わせる
/// チェックは行わない。
///
/// [sourceInstanceId]はarchiveの実体(同一pathでも中身が更新された別の
/// downloadなど)を区別するための識別子。`BaseMapTileCache`のcache keyの
/// 一部として使い、archiveが差し替わった際に古いtileのcacheを暗黙に無効化
/// する目的だけに使う(値そのものの生成規則はappが決める)。
@freezed
abstract class VerifiedPmTilesSource
    with _$VerifiedPmTilesSource
    implements VerifiedTileSource {
  const factory VerifiedPmTilesSource({
    required String sourceInstanceId,
    required String absolutePath,
    required int sizeBytes,
    required String sha256,
  }) = _VerifiedPmTilesSource;
}

/// appが検証済みの remote PMTiles archive をpackageへ渡すための契約。
///
/// [VerifiedPmTilesSource](local file)と対になる remote descriptor。
/// `eqmonitor_map`は[url]のDNS/TLS/allowlistを**再検証しない**(app側が既に
/// 検証済みの host だけを渡す前提)。package側は https scheme・非負 revision・
/// 正の size・64桁hex digest という構造不変条件だけを
/// [createVerifiedRemotePmTilesSource]で保証する。
///
/// [sourceRevision]は同一 source の basemap/hazard fallback policy
/// (revision 跨ぎの last-good 可否)を判断するための単調増加 revision。
///
/// `copyWith`は生成しない。生成すると
/// `source.copyWith(url: Uri.parse('http://...'))`のように
/// [createVerifiedRemotePmTilesSource]の検証を迂回して不正な descriptor を
/// 作れてしまい、remote reader が信頼する https/digest 境界が崩れるため。
/// 値を変えるときは必ず[createVerifiedRemotePmTilesSource]から作り直す。
@Freezed(copyWith: false)
abstract class VerifiedRemotePmTilesSource
    with _$VerifiedRemotePmTilesSource
    implements VerifiedTileSource {
  const factory VerifiedRemotePmTilesSource._({
    required String sourceInstanceId,
    required int sourceRevision,
    required Uri url,
    required int sizeBytes,
    required String sha256,
  }) = _VerifiedRemotePmTilesSource;
}

/// [VerifiedRemotePmTilesSource]を構造不変条件付きで生成する。違反時は
/// [ArgumentError](assertと違いreleaseでも必ず送出)。
VerifiedRemotePmTilesSource createVerifiedRemotePmTilesSource({
  required String sourceInstanceId,
  required int sourceRevision,
  required Uri url,
  required int sizeBytes,
  required String sha256,
}) {
  if (sourceInstanceId.trim().isEmpty) {
    throw ArgumentError.value(
      sourceInstanceId,
      'sourceInstanceId',
      'must not be blank',
    );
  }
  if (!url.isScheme('https')) {
    throw ArgumentError.value(url, 'url', 'must be an https URL');
  }
  // `Uri.parse('https:base.pmtiles')` は scheme だけを持ち authority を持たない。
  // app が DNS/TLS/allowlist を検証したのは host であって、host の無い URI は
  // その検証を通っていない。descriptor へ入れる前に弾く。
  if (!url.hasAuthority || url.host.isEmpty) {
    throw ArgumentError.value(url, 'url', 'must have a host');
  }
  if (sourceRevision.isNegative) {
    throw ArgumentError.value(
      sourceRevision,
      'sourceRevision',
      'must not be negative',
    );
  }
  if (sizeBytes <= 0) {
    throw ArgumentError.value(sizeBytes, 'sizeBytes', 'must be positive');
  }
  if (!_sha256Hex.hasMatch(sha256)) {
    throw ArgumentError.value(sha256, 'sha256', 'must be 64 hex characters');
  }

  return VerifiedRemotePmTilesSource._(
    sourceInstanceId: sourceInstanceId,
    sourceRevision: sourceRevision,
    url: url,
    sizeBytes: sizeBytes,
    sha256: sha256,
  );
}
