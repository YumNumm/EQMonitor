// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';

import 'clients/changelog_api_client.dart';
import 'clients/start_api_client.dart';
import 'clients/admin_api_client.dart';
import 'clients/device_api_client.dart';
import 'clients/notification_api_client.dart';
import 'clients/telemetry_api_client.dart';
import 'clients/earthquake_api_client.dart';
import 'clients/eew_api_client.dart';
import 'clients/feed_api_client.dart';
import 'clients/parameters_api_client.dart';
import 'clients/seismicity_api_client.dart';
import 'clients/shake_detection_api_client.dart';
import 'clients/subscription_api_client.dart';
import 'clients/telegram_api_client.dart';
import 'clients/tsunami_api_client.dart';
import 'clients/user_api_client.dart';
import 'clients/realtime_api_client.dart';
import 'clients/webhooks_api_client.dart';

/// EQMonitor Backend API `v2.0.0`.
///
/// EQMonitorのAPI仕様書.
class ApiClient {
  ApiClient(
    Dio dio, {
    String? baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  final Dio _dio;
  final String? _baseUrl;

  static String get version => '2.0.0';

  ChangelogApiClient? _changelog;
  StartApiClient? _start;
  AdminApiClient? _admin;
  DeviceApiClient? _device;
  NotificationApiClient? _notification;
  TelemetryApiClient? _telemetry;
  EarthquakeApiClient? _earthquake;
  EewApiClient? _eew;
  FeedApiClient? _feed;
  ParametersApiClient? _parameters;
  SeismicityApiClient? _seismicity;
  ShakeDetectionApiClient? _shakeDetection;
  SubscriptionApiClient? _subscription;
  TelegramApiClient? _telegram;
  TsunamiApiClient? _tsunami;
  UserApiClient? _user;
  RealtimeApiClient? _realtime;
  WebhooksApiClient? _webhooks;

  ChangelogApiClient get changelog => _changelog ??= ChangelogApiClient(_dio, baseUrl: _baseUrl);

  StartApiClient get start => _start ??= StartApiClient(_dio, baseUrl: _baseUrl);

  AdminApiClient get admin => _admin ??= AdminApiClient(_dio, baseUrl: _baseUrl);

  DeviceApiClient get device => _device ??= DeviceApiClient(_dio, baseUrl: _baseUrl);

  NotificationApiClient get notification => _notification ??= NotificationApiClient(_dio, baseUrl: _baseUrl);

  TelemetryApiClient get telemetry => _telemetry ??= TelemetryApiClient(_dio, baseUrl: _baseUrl);

  EarthquakeApiClient get earthquake => _earthquake ??= EarthquakeApiClient(_dio, baseUrl: _baseUrl);

  EewApiClient get eew => _eew ??= EewApiClient(_dio, baseUrl: _baseUrl);

  FeedApiClient get feed => _feed ??= FeedApiClient(_dio, baseUrl: _baseUrl);

  ParametersApiClient get parameters => _parameters ??= ParametersApiClient(_dio, baseUrl: _baseUrl);

  SeismicityApiClient get seismicity => _seismicity ??= SeismicityApiClient(_dio, baseUrl: _baseUrl);

  ShakeDetectionApiClient get shakeDetection => _shakeDetection ??= ShakeDetectionApiClient(_dio, baseUrl: _baseUrl);

  SubscriptionApiClient get subscription => _subscription ??= SubscriptionApiClient(_dio, baseUrl: _baseUrl);

  TelegramApiClient get telegram => _telegram ??= TelegramApiClient(_dio, baseUrl: _baseUrl);

  TsunamiApiClient get tsunami => _tsunami ??= TsunamiApiClient(_dio, baseUrl: _baseUrl);

  UserApiClient get user => _user ??= UserApiClient(_dio, baseUrl: _baseUrl);

  RealtimeApiClient get realtime => _realtime ??= RealtimeApiClient(_dio, baseUrl: _baseUrl);

  WebhooksApiClient get webhooks => _webhooks ??= WebhooksApiClient(_dio, baseUrl: _baseUrl);
}
