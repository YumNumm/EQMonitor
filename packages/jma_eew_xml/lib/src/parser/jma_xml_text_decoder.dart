final class const JmaXmlTextDecoder() {
  static const equals = 0x3D;
  static const _ampersand = 0x26;
  static const _hash = 0x23;
  static const _lowerX = 0x78;
  static const _lt = 0x3C;

  static bool isWhitespace(int c) =>
      c == 0x20 || c == 0x0A || c == 0x09 || c == 0x0D;

  String decode(String source, int start, int end) {
    for (var i = start; i < end; i++) {
      final c = source.codeUnitAt(i);
      if (c == _ampersand || c == _lt) {
        return _decodeSlow(source, start, end);
      }
    }
    return source.substring(start, end);
  }

  String _decodeSlow(String source, int start, int end) {
    final buffer = StringBuffer();
    var i = start;
    while (i < end) {
      final c = source.codeUnitAt(i);
      if (c == _lt) {
        if (source.startsWith('<![CDATA[', i)) {
          final close = source.indexOf(']]>', i + 9);
          final stop = close < 0 || close > end ? end : close;
          buffer.write(source.substring(i + 9, stop));
          i = stop + 3;
          continue;
        }
        if (source.startsWith('<!--', i)) {
          final close = source.indexOf('-->', i + 4);
          i = close < 0 || close > end ? end : close + 3;
          continue;
        }
        final close = source.indexOf('>', i + 1);
        i = close < 0 || close > end ? end : close + 1;
        continue;
      }
      if (c == _ampersand) {
        final semicolon = source.indexOf(';', i + 1);
        if (semicolon > i && semicolon < end) {
          final decoded = _entity(source, i + 1, semicolon);
          if (decoded != null) {
            buffer.write(decoded);
            i = semicolon + 1;
            continue;
          }
        }
      }
      buffer.writeCharCode(c);
      i++;
    }
    return buffer.toString();
  }

  String? _entity(String source, int start, int end) {
    if (source.codeUnitAt(start) == _hash) {
      final isHex =
          end - start > 1 && (source.codeUnitAt(start + 1) | 0x20) == _lowerX;
      final value = int.tryParse(
        source.substring(start + (isHex ? 2 : 1), end),
        radix: isHex ? 16 : 10,
      );
      return value == null || value < 0 || value > 0x10FFFF
          ? null
          : String.fromCharCode(value);
    }
    return switch (source.substring(start, end)) {
      'lt' => '<',
      'gt' => '>',
      'amp' => '&',
      'quot' => '"',
      'apos' => "'",
      _ => null,
    };
  }
}
