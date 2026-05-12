/// K-NET/KiK-net HTTPS ダウンロードのベース URL
const knetBaseUrl = 'https://kensho-web.kyoshin.bosai.go.jp/kyoshin/download';

/// all/zip の強震波形 ZIP ファイル URL
///
/// [dateTime] 地震発生時刻（JST）
/// [format] フォーマット種別（'ascii', 'binary', 'csv'）
Uri knetAllZipUrl(DateTime dateTime, {String format = 'ascii'}) {
  final datePath = _formatDatePath(dateTime);
  final fileName = '${_formatFileName(dateTime)}_$format.zip';
  return Uri.parse('$knetBaseUrl/all/zip/$datePath/$fileName');
}

/// all/fig の PNG 図ファイル URL
///
/// [dateTime] 地震発生時刻（JST）
/// [stationType] 観測網種別（'knet', 'kik', 'all' など）
Uri knetAllFigUrl(DateTime dateTime, String stationType) {
  final datePath = _formatDatePath(dateTime);
  final fileName = '${_formatFileName(dateTime)}_$stationType.png';
  return Uri.parse('$knetBaseUrl/all/fig/$datePath/$fileName');
}

/// all/movie の MP4 動画ファイル URL
Uri knetAllMovieUrl(DateTime dateTime) {
  final datePath = _formatDatePath(dateTime);
  final fileName = '${_formatFileName(dateTime)}.mp4';
  return Uri.parse('$knetBaseUrl/all/movie/$datePath/$fileName');
}

/// knet 個別観測点波形ファイル URL
///
/// [dateTime] 地震発生時刻
/// [stationCode] 観測点コード（例: IBR011）
/// [direction] チャンネル方向（'NS', 'EW', 'UD'）
Uri knetWaveformUrl(
  DateTime dateTime,
  String stationCode,
  String direction,
) {
  final datePath = _formatDatePath(dateTime);
  final subPath = _formatFileName(dateTime);
  final fileName = '$stationCode${_formatShortDateTime(dateTime)}.$direction';
  return Uri.parse('$knetBaseUrl/knet/data/$datePath/$subPath/$fileName');
}

/// "YYYY/MM" 形式のパス部分を生成
String _formatDatePath(DateTime dt) =>
    '${dt.year}/${dt.month.toString().padLeft(2, '0')}';

/// "YYYYMMDDHHmmss" 形式のファイル名プレフィクスを生成
String _formatFileName(DateTime dt) =>
    '${dt.year}'
    '${dt.month.toString().padLeft(2, '0')}'
    '${dt.day.toString().padLeft(2, '0')}'
    '${dt.hour.toString().padLeft(2, '0')}'
    '${dt.minute.toString().padLeft(2, '0')}'
    '${dt.second.toString().padLeft(2, '0')}';

/// "YYMMDDHHmm" 形式（観測点ファイル名用）
String _formatShortDateTime(DateTime dt) =>
    '${(dt.year % 100).toString().padLeft(2, '0')}'
    '${dt.month.toString().padLeft(2, '0')}'
    '${dt.day.toString().padLeft(2, '0')}'
    '${dt.hour.toString().padLeft(2, '0')}'
    '${dt.minute.toString().padLeft(2, '0')}';
