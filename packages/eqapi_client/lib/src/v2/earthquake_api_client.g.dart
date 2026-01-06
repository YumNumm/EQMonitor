// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'earthquake_api_client.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main

class _EarthquakeApiClient implements EarthquakeApiClient {
  _EarthquakeApiClient(this._dio, {this.baseUrl, this.errorLogger});

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<EarthquakeListResponse> getList({
    int? limit,
    String? cursor,
    double? magnitudeLte,
    double? magnitudeGte,
    int? depthLte,
    int? depthGte,
    String? intensityLte,
    String? intensityGte,
    List<String>? statuses,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'limit': limit,
      r'cursor': cursor,
      r'magnitudeLte': magnitudeLte,
      r'magnitudeGte': magnitudeGte,
      r'depthLte': depthLte,
      r'depthGte': depthGte,
      r'intensityLte': intensityLte,
      r'intensityGte': intensityGte,
      r'statuses': statuses,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<EarthquakeListResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/v2/earthquake',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late EarthquakeListResponse _value;
    try {
      _value = EarthquakeListResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<EarthquakeDetailResponse> getDetail({required String eventId}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<EarthquakeDetailResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/v2/earthquake/${eventId}',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late EarthquakeDetailResponse _value;
    try {
      _value = EarthquakeDetailResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<IntensityRegionSearchResponse> searchByRegion({
    required String code,
    int? limit,
    String? cursor,
    double? magnitudeLte,
    double? magnitudeGte,
    int? depthLte,
    int? depthGte,
    String? intensityLte,
    String? intensityGte,
    List<String>? statuses,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'code': code,
      r'limit': limit,
      r'cursor': cursor,
      r'magnitudeLte': magnitudeLte,
      r'magnitudeGte': magnitudeGte,
      r'depthLte': depthLte,
      r'depthGte': depthGte,
      r'intensityLte': intensityLte,
      r'intensityGte': intensityGte,
      r'statuses': statuses,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<IntensityRegionSearchResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/v2/earthquake/intensity/region',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late IntensityRegionSearchResponse _value;
    try {
      _value = IntensityRegionSearchResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<IntensityPrefectureSearchResponse> searchByPrefecture({
    required String code,
    int? limit,
    String? cursor,
    double? magnitudeLte,
    double? magnitudeGte,
    int? depthLte,
    int? depthGte,
    String? intensityLte,
    String? intensityGte,
    List<String>? statuses,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'code': code,
      r'limit': limit,
      r'cursor': cursor,
      r'magnitudeLte': magnitudeLte,
      r'magnitudeGte': magnitudeGte,
      r'depthLte': depthLte,
      r'depthGte': depthGte,
      r'intensityLte': intensityLte,
      r'intensityGte': intensityGte,
      r'statuses': statuses,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<IntensityPrefectureSearchResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/v2/earthquake/intensity/prefecture',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late IntensityPrefectureSearchResponse _value;
    try {
      _value = IntensityPrefectureSearchResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<IntensityCitySearchResponse> searchByCity({
    required String code,
    int? limit,
    String? cursor,
    double? magnitudeLte,
    double? magnitudeGte,
    int? depthLte,
    int? depthGte,
    String? intensityLte,
    String? intensityGte,
    List<String>? statuses,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'code': code,
      r'limit': limit,
      r'cursor': cursor,
      r'magnitudeLte': magnitudeLte,
      r'magnitudeGte': magnitudeGte,
      r'depthLte': depthLte,
      r'depthGte': depthGte,
      r'intensityLte': intensityLte,
      r'intensityGte': intensityGte,
      r'statuses': statuses,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<IntensityCitySearchResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/v2/earthquake/intensity/city',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late IntensityCitySearchResponse _value;
    try {
      _value = IntensityCitySearchResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<IntensityStationSearchResponse> searchByStation({
    required String code,
    int? limit,
    String? cursor,
    double? magnitudeLte,
    double? magnitudeGte,
    int? depthLte,
    int? depthGte,
    String? intensityLte,
    String? intensityGte,
    List<String>? statuses,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'code': code,
      r'limit': limit,
      r'cursor': cursor,
      r'magnitudeLte': magnitudeLte,
      r'magnitudeGte': magnitudeGte,
      r'depthLte': depthLte,
      r'depthGte': depthGte,
      r'intensityLte': intensityLte,
      r'intensityGte': intensityGte,
      r'statuses': statuses,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<IntensityStationSearchResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/v2/earthquake/intensity/station',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late IntensityStationSearchResponse _value;
    try {
      _value = IntensityStationSearchResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}

// dart format on
