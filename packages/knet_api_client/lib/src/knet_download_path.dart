/// K-NET/KiK-net HTTPS ダウンロードのベース URL
const knetBaseUrl = 'https://www.kyoshin.bosai.go.jp/kyoshin/download';

/// all/fig/{Y}/{M}/{ts}/ 配下の PNG 図ファイル URL
///
/// [dateTime] 地震発生時刻（JST）
/// [figType] 図の種類（[KnetFigType] 参照）
Uri knetAllFigUrl(DateTime dateTime, KnetFigType figType) {
  final datePath = _formatDatePath(dateTime);
  final ts = _formatFileName(dateTime);
  final fileName = '$ts.${figType.suffix}.png';
  return Uri.parse('$knetBaseUrl/all/fig/$datePath/$ts/$fileName');
}

/// all/movie/{Y}/{M}/{ts}/ 配下の MP4 動画ファイル URL
///
/// [dateTime] 地震発生時刻（JST）
/// [movieType] 動画の種類（[KnetMovieType] 参照）
Uri knetAllMovieUrl(DateTime dateTime, KnetMovieType movieType) {
  final datePath = _formatDatePath(dateTime);
  final ts = _formatFileName(dateTime);
  final fileName = '${ts}_${movieType.suffix}.mp4';
  return Uri.parse('$knetBaseUrl/all/movie/$datePath/$ts/$fileName');
}

/// all/zip の強震波形 ZIP ファイル URL
///
/// [dateTime] 地震発生時刻（JST）
/// [format] フォーマット種別（'ascii', 'binary', 'csv'）
Uri knetAllZipUrl(DateTime dateTime, {String format = 'ascii'}) {
  final datePath = _formatDatePath(dateTime);
  final ts = _formatFileName(dateTime);
  final fileName = '${ts}_$format.zip';
  return Uri.parse('$knetBaseUrl/all/zip/$datePath/$ts/$fileName');
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

/// PNG 図の種類
enum KnetFigType {
  /// 加速度分布図
  accMap('all_accmap', '加速度分布図'),

  /// 地震動記録断面図
  recordSection('all_recordsection', '記録断面図'),

  /// 計測震度分布図
  shindoMap('all_shindomap', '震度分布図'),

  /// 速度分布図
  velMap('all_velmap', '速度分布図');

  new(this.suffix, this.label);

  final String suffix;
  final String label;
}

/// MP4 動画の種類
///
/// サフィックス `_b` は大画面版、`_s` は小画面版。
enum KnetMovieType {
  accBig('acc_b', '加速度（大）'),
  accSmall('acc_s', '加速度（小）'),
  rsiBig('rsi_b', '速度応答（大）'),
  rsiSmall('rsi_s', '速度応答（小）'),
  sv0125Big('sv0125_b', 'SV 0.125s（大）'),
  sv0125Small('sv0125_s', 'SV 0.125s（小）'),
  sv0250Big('sv0250_b', 'SV 0.25s（大）'),
  sv0250Small('sv0250_s', 'SV 0.25s（小）'),
  sv0500Big('sv0500_b', 'SV 0.5s（大）'),
  sv0500Small('sv0500_s', 'SV 0.5s（小）'),
  sv1000Big('sv1000_b', 'SV 1.0s（大）'),
  sv1000Small('sv1000_s', 'SV 1.0s（小）'),
  sv2000Big('sv2000_b', 'SV 2.0s（大）'),
  sv2000Small('sv2000_s', 'SV 2.0s（小）'),
  sv4000Big('sv4000_b', 'SV 4.0s（大）'),
  sv4000Small('sv4000_s', 'SV 4.0s（小）');

  new(this.suffix, this.label);

  final String suffix;
  final String label;
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
