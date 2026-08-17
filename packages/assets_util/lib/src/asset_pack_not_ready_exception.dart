/// Thrown when the platform-managed Asset Pack isn't available on-device yet
/// (or no longer exists).
///
/// This is deliberately the *only* failure signal for `resolvePackRoot`:
/// callers must not fall back to bundled/fake data when this is thrown. See
/// `docs/superpowers/specs/2026-07-18-asset-pack-design.md`'s Global
/// Constraints ("Pack 未取得・破損時に偽データ／固定値フォールバックは禁止").
final class AssetPackNotReadyException implements Exception {
  const new(this.message);

  final String message;

  @override
  String toString() => 'AssetPackNotReadyException: $message';
}
