import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/dio_provider.dart';
import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_distribution_manifest.dart';
import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_signature.dart';
import 'package:eqmonitor/feature/asset_pack/data/model/trusted_asset_pack_keys.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_signature_verifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:version/version.dart';

part 'asset_pack_distribution_repository.g.dart';

const assetPackDistributionBaseUrl = 'https://assets.eqmonitor.app/v1/assets';

typedef VerifyAssetPackSignature =
    Future<bool> Function({
      required Uint8List content,
      required AssetPackSignature sidecar,
    });

enum AssetPackDistributionErrorCode {
  transport,
  invalidResponse,
  signature,
  rollback,
}

class AssetPackDistributionException implements Exception {
  const AssetPackDistributionException({
    required this.code,
    required this.message,
  });

  final AssetPackDistributionErrorCode code;
  final String message;

  @override
  String toString() => 'AssetPackDistributionException($code, $message)';
}

sealed class AssetPackUpdateCheckResult {
  const AssetPackUpdateCheckResult({required this.manifest});

  final AssetPackDistributionManifest manifest;
}

final class AssetPackNoUpdate extends AssetPackUpdateCheckResult {
  const AssetPackNoUpdate({required super.manifest});
}

final class AssetPackUpdateAvailable extends AssetPackUpdateCheckResult {
  const AssetPackUpdateAvailable({
    required super.manifest,
    required this.entry,
  });

  final AssetPackDistributionEntry entry;
}

final class AssetPackAppUpdateRequired extends AssetPackUpdateCheckResult {
  const AssetPackAppUpdateRequired({
    required super.manifest,
    required this.entry,
  });

  final AssetPackDistributionEntry entry;
}

class AssetPackDistributionRepository {
  AssetPackDistributionRepository({
    required this.dio,
    required this.preferences,
    required this.verifySignature,
    this.baseUrl = assetPackDistributionBaseUrl,
  });

  final Dio dio;
  final SharedPreferencesDataSource preferences;
  final VerifyAssetPackSignature verifySignature;
  final String baseUrl;

  Future<AssetPackUpdateCheckResult> checkForUpdate({
    required String activeVersion,
    required String appVersion,
  }) async {
    final cachedEtag = await preferences.getString(
      key: SharedPreferencesKey.assetPackDistributionEtag,
    );
    final response = await fetchDistributionFile(
      dio: dio,
      url: '$baseUrl/manifest.json',
      etag: cachedEtag,
    );
    final payload = response.statusCode == 304
        ? await readCachedDistribution(preferences: preferences)
        : await fetchDistributionPayload(
            dio: dio,
            baseUrl: baseUrl,
            manifestResponse: response,
          );
    final sidecar = decodeAssetPackSignature(payload.signatureBytes);
    if (!await verifySignature(
      content: payload.manifestBytes,
      sidecar: sidecar,
    )) {
      throw const AssetPackDistributionException(
        code: AssetPackDistributionErrorCode.signature,
        message: 'Asset Pack 更新情報の署名を確認できませんでした。',
      );
    }
    final manifest = decodeDistributionManifest(payload.manifestBytes);
    await enforceAndStoreAcceptedManifest(
      preferences: preferences,
      manifest: manifest,
    );
    if (response.statusCode != 304) {
      await storeVerifiedDistribution(
        preferences: preferences,
        payload: payload,
      );
    }
    final latest = manifest.packs.first;
    if (Version.parse(latest.version) <= Version.parse(activeVersion)) {
      return AssetPackNoUpdate(manifest: manifest);
    }
    if (Version.parse(appVersion) < Version.parse(latest.minimumAppVersion)) {
      return AssetPackAppUpdateRequired(manifest: manifest, entry: latest);
    }
    return AssetPackUpdateAvailable(manifest: manifest, entry: latest);
  }
}

@Riverpod(keepAlive: true)
Future<AssetPackDistributionRepository> assetPackDistributionRepository(
  Ref ref,
) async {
  final dio = await ref.watch(dioProvider.future);
  final preferences = await ref.watch(
    sharedPreferencesDataSourceProvider.future,
  );
  final verifier = AssetPackSignatureVerifier(
    publicKeys: trustedAssetPackPublicKeys,
  );
  return AssetPackDistributionRepository(
    dio: dio,
    preferences: preferences,
    verifySignature: verifier.verify,
  );
}

class AssetPackDistributionPayload {
  const AssetPackDistributionPayload({
    required this.manifestBytes,
    required this.signatureBytes,
    this.etag,
  });

  final Uint8List manifestBytes;
  final Uint8List signatureBytes;
  final String? etag;
}

Future<Response<Uint8List>> fetchDistributionFile({
  required Dio dio,
  required String url,
  String? etag,
}) async {
  try {
    return await dio.get<Uint8List>(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        headers: {if (etag != null) 'If-None-Match': etag},
        validateStatus: (status) => status == 200 || status == 304,
      ),
    );
  } on DioException {
    throw const AssetPackDistributionException(
      code: AssetPackDistributionErrorCode.transport,
      message: 'Asset Pack 更新情報を取得できませんでした。',
    );
  }
}

Future<AssetPackDistributionPayload> fetchDistributionPayload({
  required Dio dio,
  required String baseUrl,
  required Response<Uint8List> manifestResponse,
}) async {
  final manifestBytes = manifestResponse.data;
  if (manifestBytes == null) {
    throw const AssetPackDistributionException(
      code: AssetPackDistributionErrorCode.invalidResponse,
      message: 'Asset Pack 更新情報が空です。',
    );
  }
  final signatureResponse = await fetchDistributionFile(
    dio: dio,
    url: '$baseUrl/manifest.sig',
  );
  final signatureBytes = signatureResponse.data;
  if (signatureBytes == null || signatureResponse.statusCode != 200) {
    throw const AssetPackDistributionException(
      code: AssetPackDistributionErrorCode.invalidResponse,
      message: 'Asset Pack 署名情報が空です。',
    );
  }
  return AssetPackDistributionPayload(
    manifestBytes: manifestBytes,
    signatureBytes: signatureBytes,
    etag: manifestResponse.headers.value('etag'),
  );
}

Future<void> storeVerifiedDistribution({
  required SharedPreferencesDataSource preferences,
  required AssetPackDistributionPayload payload,
}) async {
  await preferences.setString(
    key: SharedPreferencesKey.assetPackDistributionManifest,
    value: base64Encode(payload.manifestBytes),
  );
  await preferences.setString(
    key: SharedPreferencesKey.assetPackDistributionSignature,
    value: base64Encode(payload.signatureBytes),
  );
  final etag = payload.etag;
  if (etag != null) {
    await preferences.setString(
      key: SharedPreferencesKey.assetPackDistributionEtag,
      value: etag,
    );
  }
}

Future<AssetPackDistributionPayload> readCachedDistribution({
  required SharedPreferencesDataSource preferences,
}) async {
  final manifest = await preferences.getString(
    key: SharedPreferencesKey.assetPackDistributionManifest,
  );
  final signature = await preferences.getString(
    key: SharedPreferencesKey.assetPackDistributionSignature,
  );
  if (manifest == null || signature == null) {
    throw const AssetPackDistributionException(
      code: AssetPackDistributionErrorCode.invalidResponse,
      message: 'Asset Pack 更新キャッシュが見つかりません。',
    );
  }
  return AssetPackDistributionPayload(
    manifestBytes: base64Decode(manifest),
    signatureBytes: base64Decode(signature),
  );
}

AssetPackSignature decodeAssetPackSignature(Uint8List bytes) {
  final value = jsonDecode(utf8.decode(bytes));
  if (value is! Map<String, dynamic>) {
    throw const AssetPackDistributionException(
      code: AssetPackDistributionErrorCode.invalidResponse,
      message: 'Asset Pack 署名情報の形式が不正です。',
    );
  }
  return AssetPackSignature.fromJson(value);
}

AssetPackDistributionManifest decodeDistributionManifest(Uint8List bytes) {
  final value = jsonDecode(utf8.decode(bytes));
  if (value is! Map<String, dynamic>) {
    throw const AssetPackDistributionException(
      code: AssetPackDistributionErrorCode.invalidResponse,
      message: 'Asset Pack 更新情報の形式が不正です。',
    );
  }
  return AssetPackDistributionManifest.fromJson(value);
}

Future<void> enforceAndStoreAcceptedManifest({
  required SharedPreferencesDataSource preferences,
  required AssetPackDistributionManifest manifest,
}) async {
  final acceptedRevision = await preferences.getInt(
    key: SharedPreferencesKey.assetPackAcceptedRevision,
  );
  final acceptedVersion = await preferences.getString(
    key: SharedPreferencesKey.assetPackAcceptedLatestVersion,
  );
  if ((acceptedRevision != null && manifest.revision < acceptedRevision) ||
      (acceptedVersion != null &&
          Version.parse(manifest.latestVersion) <
              Version.parse(acceptedVersion))) {
    throw const AssetPackDistributionException(
      code: AssetPackDistributionErrorCode.rollback,
      message: '古い Asset Pack 更新情報を拒否しました。',
    );
  }
  await preferences.setInt(
    key: SharedPreferencesKey.assetPackAcceptedRevision,
    value: manifest.revision,
  );
  await preferences.setString(
    key: SharedPreferencesKey.assetPackAcceptedLatestVersion,
    value: manifest.latestVersion,
  );
}
