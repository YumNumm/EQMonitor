import 'package:version/version.dart';

class const ReleaseVersionParser() {
  /// プレリリースとビルドの識別子を落とした `x.y.z` を返す。
  ///
  /// 配布ビルドは beta でも `x.y.z` を名乗るため、手元のビルドの
  /// `x.y.z-beta.n` も同じリリースとして扱う。
  Version? tryParse(String source) {
    try {
      final version = Version.parse(source);
      return Version(version.major, version.minor, version.patch);
    } on FormatException {
      return null;
    }
  }
}
