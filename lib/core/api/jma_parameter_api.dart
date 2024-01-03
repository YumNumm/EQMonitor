import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jma_parameter_api_client/jma_parameter_api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'jma_parameter_api.g.dart';

@Riverpod(keepAlive: true)
JmaParameterApiClient jmaParameterApiClient(JmaParameterApiClientRef ref) {
  return JmaParameterApiClient(
    client: Dio(
      BaseOptions(
        headers: {
          'user-agent': 'eqmonitor-${kIsWeb ? "web" : Platform.version}',
          'x-operation-system-version':
              kIsWeb ? 'web' : Platform.operatingSystemVersion,
        },
        baseUrl: 'https://object.eqmonitor.app',
      ),
    ),
  );
}
