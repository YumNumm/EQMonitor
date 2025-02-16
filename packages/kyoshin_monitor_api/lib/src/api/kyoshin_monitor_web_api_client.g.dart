// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'kyoshin_monitor_web_api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations

class _KyoshinMonitorWebApiClient
    implements KyoshinMonitorWebApiClient {
  _KyoshinMonitorWebApiClient(
    this._dio, {
    this.baseUrl,
    this.errorLogger,
  }) {
    baseUrl ??= 'http://www.kmoni.bosai.go.jp';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<DataTime> getLatestDataTime() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<DataTime>(
      Options(
            method: 'GET',
            headers: _headers,
            extra: _extra,
          )
          .compose(
            _dio.options,
            '/webservice/server/pros/latest.json',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(
            baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ),
          ),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(
      _options,
    );
    late DataTime _value;
    try {
      _value = DataTime.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<MaintenanceMessage> getMaintenanceMessage() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<MaintenanceMessage>(
      Options(
            method: 'GET',
            headers: _headers,
            extra: _extra,
          )
          .compose(
            _dio.options,
            '/webservice/maintenance/message.json',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(
            baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ),
          ),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(
      _options,
    );
    late MaintenanceMessage _value;
    try {
      _value = MaintenanceMessage.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<List<int>> getBaseMapImageData({
    required String theme,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<List<int>>(
      Options(
            method: 'GET',
            headers: _headers,
            extra: _extra,
            responseType: ResponseType.bytes,
          )
          .compose(
            _dio.options,
            '/data/map_img/CommonImg/base_map_${theme}.gif',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(
            baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ),
          ),
    );
    final _result = await _dio.fetch<List<dynamic>>(
      _options,
    );
    late List<int> _value;
    try {
      _value = _result.data!.cast<int>();
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<List<int>> getScaleImageData({
    required String type,
    required String layer,
    required String theme,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<List<int>>(
      Options(
            method: 'GET',
            headers: _headers,
            extra: _extra,
            responseType: ResponseType.bytes,
          )
          .compose(
            _dio.options,
            '/data/map_img/ScaleImg/nied_${type}_${layer}_${theme}_scale.gif',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(
            baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ),
          ),
    );
    final _result = await _dio.fetch<List<dynamic>>(
      _options,
    );
    late List<int> _value;
    try {
      _value = _result.data!.cast<int>();
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<Eew> getJsonEew({required String dateTime}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<Eew>(
      Options(
            method: 'GET',
            headers: _headers,
            extra: _extra,
          )
          .compose(
            _dio.options,
            '/webservice/hypo/eew/${dateTime}.json',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(
            baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ),
          ),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(
      _options,
    );
    late Eew _value;
    try {
      _value = Eew.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<List<int>> getPsWaveImageData({
    required String date,
    required String dateTime,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<List<int>>(
      Options(
            method: 'GET',
            headers: _headers,
            extra: _extra,
            responseType: ResponseType.bytes,
          )
          .compose(
            _dio.options,
            '/data/map_img/PSWaveImg/eew/${date}/${dateTime}.gif',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(
            baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ),
          ),
    );
    final _result = await _dio.fetch<List<dynamic>>(
      _options,
    );
    late List<int> _value;
    try {
      _value = _result.data!.cast<int>();
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<List<int>> getRealtimeImageData({
    required String type,
    required String layer,
    required String date,
    required String dateTime,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<List<int>>(
      Options(
            method: 'GET',
            headers: _headers,
            extra: _extra,
            responseType: ResponseType.bytes,
          )
          .compose(
            _dio.options,
            '/data/map_img/RealTimeImg/${type}_${layer}/${date}/${dateTime}.${type}_${layer}.gif',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(
            baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ),
          ),
    );
    final _result = await _dio.fetch<List<dynamic>>(
      _options,
    );
    late List<int> _value;
    try {
      _value = _result.data!.cast<int>();
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<List<int>> getEstShindoImageData({
    required String date,
    required String dateTime,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<List<int>>(
      Options(
            method: 'GET',
            headers: _headers,
            extra: _extra,
            responseType: ResponseType.bytes,
          )
          .compose(
            _dio.options,
            '/data/map_img/EstShindoImg/eew/${date}/${dateTime}.eew.gif',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(
            baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ),
          ),
    );
    final _result = await _dio.fetch<List<dynamic>>(
      _options,
    );
    late List<int> _value;
    try {
      _value = _result.data!.cast<int>();
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(
    RequestOptions requestOptions,
  ) {
    if (T != dynamic &&
        !(requestOptions.responseType ==
                ResponseType.bytes ||
            requestOptions.responseType ==
                ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
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
