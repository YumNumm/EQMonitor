/// 全角・半角の変換拡張関数
extension StringExtension on String {
  /// 全角を半角に変換する
  String get toHalfWidth {
    return split('').map((String char) {
      final charCode = char.codeUnitAt(0);
      if (charCode >= 0xFF01 && charCode <= 0xFF5E) {
        return String.fromCharCode(charCode - 0xFEE0);
      } else if (charCode == 0x3000) {
        return String.fromCharCode(0x0020);
      } else {
        return char;
      }
    }).join();
  }

  /// 半角を全角に変換する
  String get toFullWidth {
    return split('').map((String char) {
      final charCode = char.codeUnitAt(0);
      if (charCode >= 0x0021 && charCode <= 0x007E) {
        return String.fromCharCode(charCode + 0xFEE0);
      } else if (charCode == 0x0020) {
        return String.fromCharCode(0x3000);
      } else {
        return char;
      }
    }).join();
  }
}
