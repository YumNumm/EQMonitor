final class const ApiEndpointUrl() {
  String? validate(String? value) {
    final input = value?.trim() ?? '';
    final uri = Uri.tryParse(input);
    if (input.isEmpty ||
        RegExp(r'\s').hasMatch(input) ||
        uri == null ||
        !uri.hasAuthority ||
        uri.host.isEmpty ||
        (uri.scheme != 'https' && uri.scheme != 'http')) {
      return 'http:// または https:// で始まるURLを入力してください';
    }
    if (uri.userInfo.isNotEmpty || uri.hasQuery || uri.hasFragment) {
      return 'ユーザー情報・クエリ・フラグメントは指定できません';
    }
    if (uri.path.isNotEmpty && uri.path != '/') {
      return '/v2 などのパスを含めず、サーバのURLを入力してください';
    }
    if (uri.port <= 0 || uri.port > 65535) {
      return 'ポート番号は1〜65535で指定してください';
    }
    return null;
  }

  String normalize(String value) {
    final error = validate(value);
    if (error != null) {
      throw FormatException(error);
    }
    return Uri.parse(value.trim()).replace(path: '').toString();
  }
}
