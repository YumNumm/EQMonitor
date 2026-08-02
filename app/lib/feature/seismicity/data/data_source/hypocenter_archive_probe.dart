import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_api_exception.dart';

class HypocenterArchiveProbe {
  const HypocenterArchiveProbe({required Dio dio}) : _dio = dio;

  final Dio _dio;

  Future<Result<void, HypocenterApiException>> probe({
    required String url,
  }) async {
    try {
      final response = await _dio.get<ResponseBody>(
        url,
        options: Options(
          headers: const {'Range': 'bytes=0-127'},
          responseType: ResponseType.stream,
          validateStatus: (status) => status == 206,
        ),
      );
      final body = response.data;
      final contentRange = response.headers.value('content-range');
      final hasValidRange =
          contentRange != null &&
          RegExp(r'^bytes 0-127/\d+$').hasMatch(contentRange);
      if (response.statusCode != 206 || body == null || !hasValidRange) {
        return const Failure(
          HypocenterApiException(message: 'PMTilesのRange応答が不正です'),
        );
      }
      final bytes = await HypocenterPmTilesHeaderReader().read(body.stream);
      final signature = ascii.encode('PMTiles');
      final valid =
          bytes.length >= 8 &&
          signature.indexed.every((value) => bytes[value.$1] == value.$2) &&
          bytes[7] == 3;
      return valid
          ? const Success(null)
          : const Failure(HypocenterApiException(message: 'PMTilesヘッダーが不正です'));
    } on DioException catch (error, stackTrace) {
      return Failure(
        HypocenterApiException(
          message: 'PMTilesを確認できませんでした',
          statusCode: error.response?.statusCode,
        ),
        stackTrace,
      );
    }
  }
}

class HypocenterPmTilesHeaderReader {
  Future<Uint8List> read(Stream<Uint8List> stream) async {
    final iterator = StreamIterator(stream);
    final bytes = <int>[];
    try {
      while (bytes.length < 8 && await iterator.moveNext()) {
        bytes.addAll(iterator.current.take(8 - bytes.length));
      }
    } finally {
      await iterator.cancel();
    }
    return Uint8List.fromList(bytes);
  }
}
