// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

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
  Future<HttpResponse<EarthquakeListResponse>> getV2Earthquake({
    dynamic statuses = [NORMAL],
    EarthquakeSortBy? sortBy = EarthquakeSortBy.eventId,
    SortOrder? sortOrder = SortOrder.desc,
    String? limit,
    String? cursor,
    String? magnitudeLte,
    String? magnitudeGte,
    String? depthLte,
    String? depthGte,
    JmaIntensity? intensityLte,
    JmaIntensity? intensityGte,
    DateTime? originTimeGte,
    DateTime? originTimeLte,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'statuses': statuses.toJson(),
      r'sortBy': sortBy?.toJson(),
      r'sortOrder': sortOrder?.toJson(),
      r'limit': limit,
      r'cursor': cursor,
      r'magnitudeLte': magnitudeLte,
      r'magnitudeGte': magnitudeGte,
      r'depthLte': depthLte,
      r'depthGte': depthGte,
      r'intensityLte': intensityLte?.toJson(),
      r'intensityGte': intensityGte?.toJson(),
      r'originTimeGte': originTimeGte?.toIso8601String(),
      r'originTimeLte': originTimeLte?.toIso8601String(),
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<HttpResponse<EarthquakeListResponse>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/v2/earthquake',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late EarthquakeListResponse _value;
    try {
      _value = EarthquakeListResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<EarthquakeDetailResponse>> getV2EarthquakeEventId({
    required String eventId,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<HttpResponse<EarthquakeDetailResponse>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/v2/earthquake/${eventId}',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late EarthquakeDetailResponse _value;
    try {
      _value = EarthquakeDetailResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<IntensityRegionSearchResponse>>
  getV2EarthquakeIntensityRegionCode({
    required String code,
    dynamic statuses = [NORMAL],
    EarthquakeSortBy? sortBy = EarthquakeSortBy.eventId,
    SortOrder? sortOrder = SortOrder.desc,
    String? limit,
    String? cursor,
    String? magnitudeLte,
    String? magnitudeGte,
    String? depthLte,
    String? depthGte,
    JmaIntensity? intensityLte,
    JmaIntensity? intensityGte,
    DateTime? originTimeGte,
    DateTime? originTimeLte,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'statuses': statuses.toJson(),
      r'sortBy': sortBy?.toJson(),
      r'sortOrder': sortOrder?.toJson(),
      r'limit': limit,
      r'cursor': cursor,
      r'magnitudeLte': magnitudeLte,
      r'magnitudeGte': magnitudeGte,
      r'depthLte': depthLte,
      r'depthGte': depthGte,
      r'intensityLte': intensityLte?.toJson(),
      r'intensityGte': intensityGte?.toJson(),
      r'originTimeGte': originTimeGte?.toIso8601String(),
      r'originTimeLte': originTimeLte?.toIso8601String(),
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<HttpResponse<IntensityRegionSearchResponse>>(
          Options(method: 'GET', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/v2/earthquake/intensity/region/${code}',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late IntensityRegionSearchResponse _value;
    try {
      _value = IntensityRegionSearchResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<IntensityPrefectureSearchResponse>>
  getV2EarthquakeIntensityPrefectureCode({
    required String code,
    dynamic statuses = [NORMAL],
    EarthquakeSortBy? sortBy = EarthquakeSortBy.eventId,
    SortOrder? sortOrder = SortOrder.desc,
    String? limit,
    String? cursor,
    String? magnitudeLte,
    String? magnitudeGte,
    String? depthLte,
    String? depthGte,
    JmaIntensity? intensityLte,
    JmaIntensity? intensityGte,
    DateTime? originTimeGte,
    DateTime? originTimeLte,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'statuses': statuses.toJson(),
      r'sortBy': sortBy?.toJson(),
      r'sortOrder': sortOrder?.toJson(),
      r'limit': limit,
      r'cursor': cursor,
      r'magnitudeLte': magnitudeLte,
      r'magnitudeGte': magnitudeGte,
      r'depthLte': depthLte,
      r'depthGte': depthGte,
      r'intensityLte': intensityLte?.toJson(),
      r'intensityGte': intensityGte?.toJson(),
      r'originTimeGte': originTimeGte?.toIso8601String(),
      r'originTimeLte': originTimeLte?.toIso8601String(),
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<HttpResponse<IntensityPrefectureSearchResponse>>(
          Options(method: 'GET', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/v2/earthquake/intensity/prefecture/${code}',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late IntensityPrefectureSearchResponse _value;
    try {
      _value = IntensityPrefectureSearchResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<IntensityCitySearchResponse>>
  getV2EarthquakeIntensityCityCode({
    required String code,
    dynamic statuses = [NORMAL],
    EarthquakeSortBy? sortBy = EarthquakeSortBy.eventId,
    SortOrder? sortOrder = SortOrder.desc,
    String? limit,
    String? cursor,
    String? magnitudeLte,
    String? magnitudeGte,
    String? depthLte,
    String? depthGte,
    JmaIntensity? intensityLte,
    JmaIntensity? intensityGte,
    DateTime? originTimeGte,
    DateTime? originTimeLte,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'statuses': statuses.toJson(),
      r'sortBy': sortBy?.toJson(),
      r'sortOrder': sortOrder?.toJson(),
      r'limit': limit,
      r'cursor': cursor,
      r'magnitudeLte': magnitudeLte,
      r'magnitudeGte': magnitudeGte,
      r'depthLte': depthLte,
      r'depthGte': depthGte,
      r'intensityLte': intensityLte?.toJson(),
      r'intensityGte': intensityGte?.toJson(),
      r'originTimeGte': originTimeGte?.toIso8601String(),
      r'originTimeLte': originTimeLte?.toIso8601String(),
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<HttpResponse<IntensityCitySearchResponse>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/v2/earthquake/intensity/city/${code}',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late IntensityCitySearchResponse _value;
    try {
      _value = IntensityCitySearchResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<IntensityStationSearchResponse>>
  getV2EarthquakeIntensityStationCode({
    required String code,
    dynamic statuses = [NORMAL],
    EarthquakeSortBy? sortBy = EarthquakeSortBy.eventId,
    SortOrder? sortOrder = SortOrder.desc,
    String? limit,
    String? cursor,
    String? magnitudeLte,
    String? magnitudeGte,
    String? depthLte,
    String? depthGte,
    JmaIntensity? intensityLte,
    JmaIntensity? intensityGte,
    DateTime? originTimeGte,
    DateTime? originTimeLte,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'statuses': statuses.toJson(),
      r'sortBy': sortBy?.toJson(),
      r'sortOrder': sortOrder?.toJson(),
      r'limit': limit,
      r'cursor': cursor,
      r'magnitudeLte': magnitudeLte,
      r'magnitudeGte': magnitudeGte,
      r'depthLte': depthLte,
      r'depthGte': depthGte,
      r'intensityLte': intensityLte?.toJson(),
      r'intensityGte': intensityGte?.toJson(),
      r'originTimeGte': originTimeGte?.toIso8601String(),
      r'originTimeLte': originTimeLte?.toIso8601String(),
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<HttpResponse<IntensityStationSearchResponse>>(
          Options(method: 'GET', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/v2/earthquake/intensity/station/${code}',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late IntensityStationSearchResponse _value;
    try {
      _value = IntensityStationSearchResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<EpicenterSearchResponse>> getV2EarthquakeEpicenterCode({
    required String code,
    dynamic statuses = [NORMAL],
    EarthquakeSortBy? sortBy = EarthquakeSortBy.eventId,
    SortOrder? sortOrder = SortOrder.desc,
    String? limit,
    String? cursor,
    String? magnitudeLte,
    String? magnitudeGte,
    String? depthLte,
    String? depthGte,
    JmaIntensity? intensityLte,
    JmaIntensity? intensityGte,
    DateTime? originTimeGte,
    DateTime? originTimeLte,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'statuses': statuses.toJson(),
      r'sortBy': sortBy?.toJson(),
      r'sortOrder': sortOrder?.toJson(),
      r'limit': limit,
      r'cursor': cursor,
      r'magnitudeLte': magnitudeLte,
      r'magnitudeGte': magnitudeGte,
      r'depthLte': depthLte,
      r'depthGte': depthGte,
      r'intensityLte': intensityLte?.toJson(),
      r'intensityGte': intensityGte?.toJson(),
      r'originTimeGte': originTimeGte?.toIso8601String(),
      r'originTimeLte': originTimeLte?.toIso8601String(),
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<HttpResponse<EpicenterSearchResponse>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/v2/earthquake/epicenter/${code}',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, Object?>>(_options);
    late EpicenterSearchResponse _value;
    try {
      _value = EpicenterSearchResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
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
