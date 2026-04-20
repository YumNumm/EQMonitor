// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';

import 'clients/admin_api_client.dart';
import 'clients/device_api_client.dart';
import 'clients/notification_api_client.dart';
import 'clients/earthquake_api_client.dart';
import 'clients/eew_api_client.dart';
import 'clients/telegram_api_client.dart';
import 'clients/tsunami_api_client.dart';
import 'clients/user_api_client.dart';
import 'clients/realtime_api_client.dart';

/// EQMonitor Backend API `v2.0.0`.
///
/// EQMonitorのAPI仕様書.
class ApiClient {
  ApiClient(
    Dio dio, {
    String? baseUrl,
  }) : _dio = dio,
       _baseUrl = baseUrl;

  final Dio _dio;
  final String? _baseUrl;

  static String get version => '2.0.0';

  AdminApiClient? _admin;
  DeviceApiClient? _device;
  NotificationApiClient? _notification;
  EarthquakeApiClient? _earthquake;
  EewApiClient? _eew;
  TelegramApiClient? _telegram;
  TsunamiApiClient? _tsunami;
  UserApiClient? _user;
  RealtimeApiClient? _realtime;

  AdminApiClient get admin =>
      _admin ??= AdminApiClient(_dio, baseUrl: _baseUrl);

  DeviceApiClient get device =>
      _device ??= DeviceApiClient(_dio, baseUrl: _baseUrl);

  NotificationApiClient get notification =>
      _notification ??= NotificationApiClient(_dio, baseUrl: _baseUrl);

  EarthquakeApiClient get earthquake =>
      _earthquake ??= EarthquakeApiClient(_dio, baseUrl: _baseUrl);

  EewApiClient get eew => _eew ??= EewApiClient(_dio, baseUrl: _baseUrl);

  TelegramApiClient get telegram =>
      _telegram ??= TelegramApiClient(_dio, baseUrl: _baseUrl);

  TsunamiApiClient get tsunami =>
      _tsunami ??= TsunamiApiClient(_dio, baseUrl: _baseUrl);

  UserApiClient get user => _user ??= UserApiClient(_dio, baseUrl: _baseUrl);

  RealtimeApiClient get realtime =>
      _realtime ??= RealtimeApiClient(_dio, baseUrl: _baseUrl);
}
