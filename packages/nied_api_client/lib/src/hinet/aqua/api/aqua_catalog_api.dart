import 'package:dio/dio.dart';
import 'package:nied_api_client/nied_api_client.dart' show AquaHtmlParser;
import 'package:nied_api_client/src/hinet/aqua/parser/aqua_html_parser.dart'
    show AquaHtmlParser;
import 'package:retrofit/retrofit.dart';

part 'aqua_catalog_api.g.dart';

/// AQUAカタログAPI
///
/// 防災科研のAQUAシステムのカタログページからデータを取得します
@RestApi(baseUrl: 'https://www.hinet.bosai.go.jp')
abstract class AquaCatalogApi {
  /// ファクトリコンストラクタ
  factory AquaCatalogApi(Dio dio, {String baseUrl}) = _AquaCatalogApi;

  /// カタログHTMLを取得
  ///
  /// HTMLパースには [AquaHtmlParser.parseCatalog] を使用してください
  ///
  /// [year] 年（2004以上、nullの場合は最新）
  /// [month] 月（1-12、year=2004の場合は8以上、nullの場合は最新）
  /// [lang] 言語コード（'ja' または 'en'）
  ///
  /// 制約:
  /// - year, month は両方null または両方not null
  /// - (year, month) >= (2004, 8) である必要がある
  ///
  /// Returns: カタログページのHTML
  ///
  /// Example:
  /// ```dart
  /// // パラメータのバリデーション
  /// AquaCatalogValidator.validateYearMonth(2025, 9);
  ///
  /// // カタログHTML取得
  /// final response = await api.getCatalogHtml(
  ///   year: 2025,
  ///   month: 9,
  ///   lang: Language.japanese.code,
  /// );
  ///
  /// // HTMLパース
  /// final parser = AquaHtmlParser();
  /// final events = parser.parseCatalog(response.data);
  /// ```
  @GET('/AQUA/aqua_catalogue.php')
  @DioResponseType(ResponseType.bytes)
  Future<HttpResponse<List<int>>> getCatalogHtml({
    @Query('y') String? year,
    @Query('m') String? month,
    @Query('LANG') String lang = 'ja',
    @ReceiveProgress() ProgressCallback? onReceiveProgress,
  });
}
