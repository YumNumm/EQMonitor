const _fullLengthCode = 65248;

extension JapaneseString on String {
  String alphanumericToFullLength() {
    final regex = RegExp(r'^[a-zA-Z0-9]+$');
    final string = runes.map<String>((rune) {
      final char = String.fromCharCode(rune);
      return regex.hasMatch(char)
          ? String.fromCharCode(rune + _fullLengthCode)
          : char;
    });
    return string.join();
  }

  String alphanumericToHalfLength() {
    final regex = RegExp(r'^[Ａ-Ｚａ-ｚ０-９]+$');
    final string = runes.map<String>((rune) {
      final char = String.fromCharCode(rune);
      return regex.hasMatch(char)
          ? String.fromCharCode(rune - _fullLengthCode)
          : char;
    });
    return string.join();
  }
}
