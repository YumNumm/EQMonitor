import 'dart:convert';
import 'dart:io';

import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/core/provider/api_user_agent_builder.dart';
import 'package:eqmonitor/core/provider/dio_base_options.dart';
import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/core/provider/telegram_url/model/telegram_url_model.dart';
import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_manifest.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_repository.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_storage_root_resolver.dart';
import 'package:eqmonitor/feature/location/data/headless/headless_device_location_runner.dart';
import 'package:eqmonitor/feature/location/data/jma_region_resolver.dart';
import 'package:eqmonitor/feature/location/data/logic/background_location_sync_lease.dart';
import 'package:eqmonitor/feature/location/data/logic/device_location_sync_service.dart';
import 'package:eqmonitor/feature/location/data/model/device_location_payload.dart';
import 'package:eqmonitor/feature/location/data/model/headless_api_identity.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_sync_state_repository.dart';
import 'package:eqmonitor/feature/parameter/data/repository/parameter_json_parser.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_slot_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:jma_map/jma_map.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:version/version.dart';

typedef GetActiveHeadlessTaskId = Future<String?> Function();
typedef RunHeadlessDeviceLocationTask = Future<HeadlessTaskResult> Function({
  required String taskUpdateId,
});

class HeadlessDeviceLocationDependencies {
  const new({
    this.getActiveHeadlessTaskId,
    this.runHeadlessTask,
  });

  final GetActiveHeadlessTaskId? getActiveHeadlessTaskId;
  final RunHeadlessDeviceLocationTask? runHeadlessTask;

  Future<void> run() async {
    final taskUpdateId =
        await (getActiveHeadlessTaskId ??
            BackgroundLocationTracker.getActiveHeadlessTaskId)();
    if (taskUpdateId == null) {
      return;
    }
    final taskRunner = runHeadlessTask;
    if (taskRunner != null) {
      await taskRunner(taskUpdateId: taskUpdateId);
      return;
    }
    await const HeadlessDeviceLocationTaskFactory().run(
      taskUpdateId: taskUpdateId,
    );
  }
}

class HeadlessDeviceLocationTaskFactory {
  const new();

  Future<HeadlessTaskResult> run({required String taskUpdateId}) {
    return HeadlessDeviceLocationRunner(
      bridge: const BackgroundLocationTrackerHeadlessBridge(),
      createSyncService: () => HeadlessDeviceLocationSyncServiceLoader(
        SharedPreferencesAsync(),
      ).load(),
      recordTerminalFailure: ({required updateId, required statusCode}) =>
          HeadlessDeviceLocationDiagnosticRecorder(
            SharedPreferencesAsync(),
          ).recordTerminalFailure(
            updateId: updateId,
            statusCode: statusCode,
          ),
    ).run(taskUpdateId: taskUpdateId);
  }
}

class HeadlessDeviceLocationSyncServiceLoader {
  new(this.preferences);

  final SharedPreferencesAsync preferences;

  Future<DeviceLocationSyncService> load() async {
    final stateRepository = SharedPreferencesDeviceLocationSyncStateRepository(
      preferences,
    );
    final deviceToken = await const HeadlessSecureDeviceTokenLoader().load();
    final resolver = await HeadlessJmaRegionResolverLoader(preferences).load();
    final restApiUrl = await HeadlessRestApiUrlLoader(preferences).load();
    final scope = DeviceLocationSyncScope.fromApiBaseUrl(
      apiBaseUrl: restApiUrl,
    );
    final identity = await const HeadlessApiIdentityLoader().load();
    final dio = const HeadlessApiDioFactory().build(
      baseUrl: restApiUrl,
      identity: identity,
      deviceToken: deviceToken,
    );
    return HeadlessDeviceLocationSyncServiceBuilder.build(
      scope: scope,
      stateRepository: stateRepository,
      resolver: resolver,
      repository: NotificationSlotRepository(api: api.ApiClient(dio)),
    );
  }
}

class HeadlessSecureDeviceTokenLoader {
  const new();

  Future<String?> load() {
    const storage = FlutterSecureStorage(
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock_this_device,
        groupId: 'group.net.yumnumm.eqmonitor',
      ),
    );
    return SecurePreferencesDataSource(secureStorage: storage).getString(
      key: SecureStorageKey.deviceToken,
    );
  }
}

class HeadlessJmaRegionResolverLoader {
  new(this.preferences);

  final SharedPreferencesAsync preferences;

  Future<JmaRegionResolver> load() async {
    final mapBytes = await rootBundle.load(Assets.jmaMap);
    final mapData = const HeadlessJmaMapParser().parse(mapBytes);
    final parameterSource = await const HeadlessEarthquakeParameterAssetLoader()
        .load(preferences: preferences);
    final earthquakeParameter = const ParameterJsonParser().parseEarthquake(
      parameterSource,
    );
    return JmaRegionResolver(
      cityMapData: mapData.areaInformationCity,
      tsunamiMapData: mapData.areaTsunami,
      earthquakeParameter: earthquakeParameter,
    );
  }
}

class HeadlessEarthquakeParameterAssetLoader {
  const new();

  static const bundledPrefix = 'assets/platform/';

  Future<String> load({
    required SharedPreferencesAsync preferences,
  }) async {
    final bundledManifest = await loadBundledManifest(bundle: rootBundle);
    final activeVersion = await preferences.getString(
      SharedPreferencesKey.assetPackActiveDownloadedVersion.key,
    );
    if (activeVersion != null &&
        RegExp(r'^\d+\.\d+\.\d+$').hasMatch(activeVersion)) {
      if (Version.parse(activeVersion) <
          Version.parse(bundledManifest.packVersion)) {
        await preferences.remove(
          SharedPreferencesKey.assetPackActiveDownloadedVersion.key,
        );
        return loadBundledAsset(
          bundle: rootBundle,
          manifest: bundledManifest,
        );
      }
      try {
        final storageRoot = await const AssetPackStorageRootResolver()
            .resolve();
        final repository = AssetPackRepository(
          resolvePackRoot: () async => p.join(
            storageRoot.path,
            'packs',
            activeVersion,
          ),
        );
        final downloadedManifest = await repository.readManifest();
        if (downloadedManifest.packVersion != activeVersion) {
          throw const AssetPackNotReadyException(
            'Active Asset Pack version does not match its manifest',
          );
        }
        final file = await repository.resolveAsset(
          AssetPackAssetId.earthquakeStations,
        );
        return await file.readAsString();
      } on AssetPackNotReadyException {
        await preferences.remove(
          SharedPreferencesKey.assetPackActiveDownloadedVersion.key,
        );
      }
    }
    return loadBundledAsset(bundle: rootBundle, manifest: bundledManifest);
  }

  Future<String> loadBundled({required AssetBundle bundle}) async {
    final manifest = await loadBundledManifest(bundle: bundle);
    return loadBundledAsset(bundle: bundle, manifest: manifest);
  }

  Future<AssetPackManifest> loadBundledManifest({
    required AssetBundle bundle,
  }) async {
    final manifestJson = jsonDecode(
      await bundle.loadString('${bundledPrefix}manifest.json'),
    );
    if (manifestJson is! Map<String, dynamic>) {
      throw const FormatException('Asset Pack manifest root must be an object');
    }
    return AssetPackManifest.fromJson(manifestJson);
  }

  Future<String> loadBundledAsset({
    required AssetBundle bundle,
    required AssetPackManifest manifest,
  }) async {
    final item = manifest.findAsset(
      AssetPackAssetId.earthquakeStations,
    );
    if (item == null) {
      throw const FormatException(
        'Asset Pack does not contain earthquake stations',
      );
    }
    final data = await bundle.load('$bundledPrefix${item.path}');
    final bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );
    if (bytes.length != item.sizeBytes ||
        sha256.convert(bytes).toString() != item.sha256) {
      throw const FormatException('Earthquake stations asset is corrupted');
    }
    return utf8.decode(bytes);
  }
}

class HeadlessJmaMapParser {
  const new();

  Map<JmaMapType, JmaMap_JmaMapData> parse(ByteData bytes) {
    final jmaMap = JmaMap.fromBuffer(
      bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
    );
    final result = <JmaMapType, JmaMap_JmaMapData>{};
    for (final element in jmaMap.data) {
      try {
        result[element.mapType.mapType] = element;
      } on UnimplementedError {
        continue;
      }
    }
    return result;
  }
}

class HeadlessRestApiUrlLoader {
  new(this.preferences);

  final SharedPreferencesAsync preferences;

  Future<String> load() async => const HeadlessRestApiUrlResolver().resolve(
    buildConfig: BuildConfig.fromEnvironment(),
    savedTelegramUrlJson: await preferences.getString(
      SharedPreferencesKey.telegramUrl.key,
    ),
  );
}

class HeadlessRestApiUrlResolver {
  const new();

  String resolve({
    required BuildConfig buildConfig,
    required String? savedTelegramUrlJson,
  }) {
    if (savedTelegramUrlJson == null) {
      return buildConfig.restApiUrl;
    }
    try {
      final decoded = jsonDecode(savedTelegramUrlJson);
      if (decoded is! Map<String, dynamic>) {
        return buildConfig.restApiUrl;
      }
      return TelegramUrlModel.fromJson(decoded).restApiUrl;
    } on Object {
      return buildConfig.restApiUrl;
    }
  }
}

class HeadlessApiIdentityLoader {
  const new();

  Future<HeadlessApiIdentity> load() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = Platform.isAndroid
        ? await deviceInfo.androidInfo
        : null;
    final iosInfo = Platform.isIOS ? await deviceInfo.iosInfo : null;
    final deviceId = HeadlessDeviceIdBuilder.build(await FlutterUdid.udid);
    return HeadlessApiIdentity(
      userAgent: const ApiUserAgentBuilder().build(
        packageInfo: packageInfo,
        androidDeviceInfo: androidInfo,
        iosDeviceInfo: iosInfo,
      ),
      version: '${packageInfo.version}+${packageInfo.buildNumber}',
      platform: Platform.isAndroid ? 'android' : 'ios',
      deviceId: deviceId,
    );
  }
}

class HeadlessDeviceIdBuilder {
  const new _();

  static String build(String udid) {
    final hash = sha512.convert(utf8.encode(udid)).toString();
    return '${hash.substring(0, 8)}-${hash.substring(8, 12)}-'
        '${hash.substring(12, 16)}-${hash.substring(16, 20)}-'
        '${hash.substring(20, 32)}';
  }
}

class HeadlessApiDioFactory {
  const new();

  Dio build({
    required String baseUrl,
    required HeadlessApiIdentity identity,
    required String? deviceToken,
  }) {
    final dio = Dio(DioBaseOptionsFactory.build(baseUrl: baseUrl));
    dio.options
      ..headers.addAll({
        HttpHeaders.userAgentHeader: identity.userAgent,
        'x-eqmonitor-version': identity.version,
        'x-eqmonitor-platform': identity.platform,
        if (identity.deviceId.isNotEmpty)
          'x-eqmonitor-device-id': identity.deviceId,
        if (deviceToken != null && deviceToken.isNotEmpty)
          HttpHeaders.authorizationHeader: 'Bearer $deviceToken',
      })
      ..connectTimeout = const Duration(seconds: 10)
      ..sendTimeout = const Duration(seconds: 10)
      ..receiveTimeout = const Duration(seconds: 30);
    return dio;
  }
}

class HeadlessDeviceLocationSyncServiceBuilder {
  const new _();

  static DeviceLocationSyncService build({
    required DeviceLocationSyncScope scope,
    required DeviceLocationSyncStateRepository stateRepository,
    required JmaRegionResolver resolver,
    required NotificationSlotRepository repository,
    DeviceLocationSyncLeaseManager leaseManager =
        const BackgroundLocationSyncLeaseManager(),
  }) => DeviceLocationSyncService(
    scope: scope,
    leaseManager: leaseManager,
    stateRepository: stateRepository,
    resolvePayload: ({required latitude, required longitude}) async {
      final resolution = resolver.resolveEarthquakeRegion(latitude, longitude);
      if (resolution == null) {
        return null;
      }
      return DeviceLocationPayload(
        region: resolution.regionCode.toString(),
        city: resolution.cityCode,
        tsunamiForecastRegion: resolver.resolveTsunamiForecastRegionCode(
          latitude,
          longitude,
        ),
      );
    },
    sendPayload: ({required payload}) async {
      final region = int.tryParse(payload.region);
      if (region == null) {
        throw StateError('Device Location region must be numeric');
      }
      await repository.putDeviceLocation(
        region: region,
        city: payload.city,
        tsunamiForecastRegion: payload.tsunamiForecastRegion,
      );
    },
  );
}

class HeadlessDeviceLocationDiagnosticRecorder {
  new(this.preferences);

  final SharedPreferencesAsync preferences;

  Future<void> recordTerminalFailure({
    required String updateId,
    required int statusCode,
  }) => preferences.setString(
    SharedPreferencesKey.backgroundLocationHeadlessDiagnostic.key,
    jsonEncode({
      'updateId': updateId,
      'result': HeadlessTaskResult.terminalFailure.name,
      'statusCode': statusCode,
    }),
  );
}
