// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:eqmonitor/core/api/jma_parameter_api.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:eqmonitor/core/provider/application_documents_directory.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:jma_parameter_api_client/jma_parameter_api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'jma_parameter.g.dart';

typedef JmaParameterState =
    ({
      EarthquakeParameter earthquake,
      TsunamiParameter tsunami,
      ParameterStatus earthquakeStatus,
      ParameterStatus tsunamiStatus,
    });

@Riverpod(keepAlive: true)
class JmaParameter extends _$JmaParameter {
  @override
  Stream<JmaParameterState> build() async* {
    final streamController = StreamController<JmaParameterState>();
    ref.onDispose(streamController.close);

    final earthquakeStream = getEarthquake();
    final tsunamiStream = getTsunami();

    EarthquakeParameter? earthquake;
    ParameterStatus? earthquakeStatus;
    TsunamiParameter? tsunami;
    ParameterStatus? tsunamiStatus;

    void sendIfNotNull() {
      if (earthquake != null && tsunami != null) {
        streamController.add((
          earthquake: earthquake!,
          tsunami: tsunami!,
          earthquakeStatus: earthquakeStatus!,
          tsunamiStatus: tsunamiStatus!,
        ));
      }
    }

    earthquakeStream.listen((value) {
      earthquake = value.$1;
      earthquakeStatus = value.$2;
      sendIfNotNull();
    });

    tsunamiStream.listen((value) {
      tsunami = value.$1;
      tsunamiStatus = value.$2;
      sendIfNotNull();
    });

    yield* streamController.stream;
  }

  static const _tsunamiKey = 'jma_parameter_tsunami';

  static const _earthquakeFileName = 'earthquake_param.pb';
  static const _tsunamiFileName = 'tsunami_param.pb';

  Stream<(EarthquakeParameter, ParameterStatus)> getEarthquake() async* {
    yield (await _getEarthquakeFromLocal(), ParameterStatus.asset);
    // ローカルにあったらとりあえず先に返す
    final localResult = await _getEarthquakeFromLocalCache();
    if (localResult case Success(:final value)) {
      yield (value, ParameterStatus.cachedLocal);
    }

    final cachedEtag = ref.read(earthquakeParameterEtagProvider);
    // check Etag
    final currentEtag =
        await ref
            .watch(jmaParameterApiClientProvider)
            .getEarthquakeParameterHead();
    talker.log('Earthquake cachedEtag: $cachedEtag, currentEtag: $currentEtag');
    if (cachedEtag != null && cachedEtag == currentEtag && !kIsWeb) {
      final localResult = await _getEarthquakeFromLocalCache();
      if (localResult case Success(:final value)) {
        yield (value, ParameterStatus.cachedLocal);
        return;
      }
    }
    // ETagが一致しない場合はAPIから再取得する
    final result =
        await ref.watch(jmaParameterApiClientProvider).getEarthquakeParameter();
    if (!kIsWeb) {
      await _saveEarthquakeToLocalCache(result.parameter);
    }
    final etag = result.etag;
    if (etag != null) {
      await ref.read(earthquakeParameterEtagProvider.notifier).set(etag);
    }
    yield (result.parameter, ParameterStatus.remote);
  }

  Future<EarthquakeParameter> _getEarthquakeFromLocal() async {
    final bytes = await rootBundle.load(Assets.parameter.earthquake);
    return EarthquakeParameter.fromBuffer(bytes.buffer.asUint8List());
  }

  Future<Result<EarthquakeParameter, Exception>>
  _getEarthquakeFromLocalCache() async {
    final dir = ref.read(applicationDocumentsDirectoryProvider);
    final file = File('${dir.path}/$_earthquakeFileName');
    if (file.existsSync()) {
      final buffer = await file.readAsBytes();
      try {
        return Result.success(EarthquakeParameter.fromBuffer(buffer));
      } on Exception catch (e) {
        return Result.failure(e);
      }
    } else {
      return Result.failure(Exception('File not found'));
    }
  }

  Future<void> _saveEarthquakeToLocalCache(
    EarthquakeParameter earthquake,
  ) async {
    final dir = ref.read(applicationDocumentsDirectoryProvider);
    final file = File('${dir.path}/$_earthquakeFileName');
    await file.writeAsBytes(earthquake.writeToBuffer());
  }

  Stream<(TsunamiParameter, ParameterStatus)> getTsunami() async* {
    yield (await _getTsunamiFromLocal(), ParameterStatus.asset);

    final prefs = ref.watch(sharedPreferencesProvider);
    final cachedEtag = prefs.getString(_tsunamiKey);
    // check Etag
    final currentEtag =
        await ref
            .watch(jmaParameterApiClientProvider)
            .getTsunamiParameterHeadEtag();
    talker.log('Tsunami cachedEtag: $cachedEtag, currentEtag: $currentEtag');
    if (cachedEtag != null && cachedEtag == currentEtag && !kIsWeb) {
      final localResult = await _getTsunamiFromLocalCache();
      if (localResult case Success(:final value)) {
        yield (value, ParameterStatus.cachedLocal);
        return;
      }
    }
    // ETagが一致しない場合はAPIから再取得する
    final result =
        await ref.watch(jmaParameterApiClientProvider).getTsunamiParameter();
    if (!kIsWeb) {
      await _saveTsunamiToLocalCache(result.parameter);
    }
    final etag = result.etag;
    if (etag != null) {
      await prefs.setString(_tsunamiKey, etag);
    }
    yield (result.parameter, ParameterStatus.remote);
  }

  Future<TsunamiParameter> _getTsunamiFromLocal() async {
    final bytes = await rootBundle.load(Assets.parameter.tsunami);
    return TsunamiParameter.fromBuffer(bytes.buffer.asUint8List());
  }

  Future<Result<TsunamiParameter, Exception>>
  _getTsunamiFromLocalCache() async {
    final dir = ref.read(applicationDocumentsDirectoryProvider);
    final file = File('${dir.path}/$_tsunamiFileName');
    log('Tsunami file path: ${file.path}');
    if (file.existsSync()) {
      final buffer = await file.readAsBytes();
      try {
        return Result.success(TsunamiParameter.fromBuffer(buffer));
      } on Exception catch (e) {
        return Result.failure(e);
      }
    } else {
      return Result.failure(Exception('File not found'));
    }
  }

  Future<void> _saveTsunamiToLocalCache(TsunamiParameter tsunami) async {
    final dir = ref.read(applicationDocumentsDirectoryProvider);
    final file = File('${dir.path}/$_tsunamiFileName');
    await file.writeAsBytes(tsunami.writeToBuffer());
  }
}

@Riverpod(keepAlive: true)
class EarthquakeParameterEtag extends _$EarthquakeParameterEtag {
  @override
  String? build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getString(_prefsKey);
  }

  Future<void> set(String etag) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_prefsKey, etag);
    state = etag;
  }

  static const _prefsKey = 'jma_parameter_earthquake';
}

enum ParameterStatus {
  /// Asset
  asset,

  /// キャッシュ済みローカル (Remoteチェック済み)
  cachedLocal,

  /// リモート
  remote,
}
