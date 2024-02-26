// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:eqmonitor/core/api/jma_parameter_api.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/application_documents_directory.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:jma_parameter_api_client/jma_parameter_api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'jma_parameter.g.dart';

@Riverpod(
  keepAlive: true,
)
class JmaParameter extends _$JmaParameter {
  @override
  Future<
      ({
        EarthquakeParameter earthquake,
        TsunamiParameter tsunami,
      })> build() async {
    return (
      earthquake: await getEarthquake(),
      tsunami: await getTsunami(),
    );
  }

  static const _tsunamiKey = 'jma_parameter_tsunami';

  static const _earthquakeFileName = 'earthquake_param.pb';
  static const _tsunamiFileName = 'tsunami_param.pb';

  Future<EarthquakeParameter> getEarthquake() async {
    final cachedEtag = ref.read(earthquakeParameterEtagProvider);
    // check Etag
    final currentEtag = await ref
        .watch(jmaParameterApiClientProvider)
        .getEarthquakeParameterHead();
    ref
        .read(talkerProvider)
        .log('Earthquake cachedEtag: $cachedEtag, currentEtag: $currentEtag');
    if (cachedEtag != null && cachedEtag == currentEtag && !kIsWeb) {
      final localResult = await _getEarthquakeFromLocal();
      if (localResult case Success(:final value)) {
        return value;
      }
    }
    final result =
        await ref.watch(jmaParameterApiClientProvider).getEarthquakeParameter();
    if (!kIsWeb) {
      await _saveEarthquakeToLocal(result.parameter);
    }
    final etag = result.etag;
    if (etag != null) {
      await ref.read(earthquakeParameterEtagProvider.notifier).set(etag);
    }
    return result.parameter;
  }

  Future<Result<EarthquakeParameter, Exception>>
      _getEarthquakeFromLocal() async {
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

  Future<void> _saveEarthquakeToLocal(EarthquakeParameter earthquake) async {
    final dir = ref.read(applicationDocumentsDirectoryProvider);
    final file = File('${dir.path}/$_earthquakeFileName');
    await file.writeAsBytes(earthquake.writeToBuffer());
  }

  Future<TsunamiParameter> getTsunami() async {
    final prefs = ref.watch(sharedPreferencesProvider);
    final cachedEtag = prefs.getString(_tsunamiKey);
    // check Etag
    final currentEtag = await ref
        .watch(jmaParameterApiClientProvider)
        .getTsunamiParameterHeadEtag();
    ref
        .read(talkerProvider)
        .log('Tsunami cachedEtag: $cachedEtag, currentEtag: $currentEtag');
    if (cachedEtag != null && cachedEtag == currentEtag && !kIsWeb) {
      final localResult = await _getTsunamiFromLocal();
      if (localResult case Success(:final value)) {
        return value;
      }
    }
    final result =
        await ref.watch(jmaParameterApiClientProvider).getTsunamiParameter();
    if (!kIsWeb) {
      await _saveTsunamiToLocal(result.parameter);
    }
    final etag = result.etag;
    if (etag != null) {
      await prefs.setString(_tsunamiKey, etag);
    }
    return result.parameter;
  }

  Future<Result<TsunamiParameter, Exception>> _getTsunamiFromLocal() async {
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

  Future<void> _saveTsunamiToLocal(TsunamiParameter tsunami) async {
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
