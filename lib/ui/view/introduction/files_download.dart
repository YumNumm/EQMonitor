// ignore_for_file: avoid_catching_errors

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eqmonitor/provider/init/talker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:restart_app/restart_app.dart';

import '../../../env/env.dart';
import '../../../provider/init/application_support_dir.dart';
import '../../../provider/init/shared_preferences.dart';
import '../../../schema/remote/dmdata/parameter-earthquake/parameter-earthquake.dart';

class FilesDownloadWidget extends HookConsumerWidget {
  const FilesDownloadWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFinished = useState<bool>(false);
    final isDownloading = useState<bool>(false);
    final showRetry = useState<bool>(false);
    final downloadingStatus = useState<String>('0%');

    final talker = ref.watch(talkerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('観測点データの取得'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const Text('このアプリを利用するためには、観測点データをダウンロードする必要があります。'),
            const Text('観測点データをダウンロードするには、以下のボタンを押してください。'),
            const Divider(),
            if (isDownloading.value)
              Text(downloadingStatus.value)
            else if (!isFinished.value)
              FloatingActionButton.extended(
                onPressed: () async {
                  isDownloading.value = true;
                  showRetry.value = false;
                  downloadingStatus.value = '開始しています...';
                  try {
                    await Dio().download(
                      'https://api.dmdata.jp/v2/parameter/earthquake/station',
                      '${ref.read(applicationSupportDirectoryProvider).path}/parameter-earthquake.json',
                      onReceiveProgress: (received, total) {
                        downloadingStatus.value =
                            'ファイル1/2をダウンロード中... (${(received / 1024).toStringAsFixed(1)}KB)';
                      },
                      options: Options(
                        headers: {
                          'Authorization':
                              'Basic ${base64.encode(utf8.encode(Env.dmdataKey))}',
                          'Referer': 'https://${Env.dmdataOrigin}/',
                        },
                      ),
                    );
                    downloadingStatus.value = 'ファイル1/2のダウンロード完了... ';
                    await Dio().download(
                      'https://raw.githubusercontent.com/EQMonitor/EQMonitor/main/public/arv.json',
                      '${ref.read(applicationSupportDirectoryProvider).path}/arv.json',
                      onReceiveProgress: (received, total) {
                        downloadingStatus.value =
                            'ファイル2/2をダウンロード中... (${(received / 1024).toStringAsFixed(1)}KB)';
                      },
                    );
                    downloadingStatus.value = 'ファイル2/2のダウンロード完了... ';
                    // Merge処理
                    final param = await File(
                      '${ref.read(applicationSupportDirectoryProvider).path}/parameter-earthquake.json',
                    ).readAsString();
                    final arv = await File(
                      '${ref.read(applicationSupportDirectoryProvider).path}/arv.json',
                    ).readAsString();
                    final data = ParameterEarthquake.fromTwoJson(
                      json.decode(param) as Map<String, dynamic>,
                      json.decode(arv) as Map<String, dynamic>,
                    );
                    await File(
                      '${ref.read(applicationSupportDirectoryProvider).path}/parameter-earthquake-with-arv.json',
                    ).writeAsString(json.encode(data));

                    isFinished.value = true;
                    isDownloading.value = false;
                    // 初期化済みフラグを立てる
                    await ref
                        .read(sharedPreferencesProvder)
                        .setBool('isInitializated', true);
                  } on DioError catch (e) {
                    downloadingStatus.value = 'ダウンロード中にエラーが発生しました。\n'
                        '${e.message}\n'
                        '${e.response?.data}';
                    talker.error(e.response?.data);
                    showRetry.value = true;
                  } on Error catch (e) {
                    downloadingStatus.value = 'エラーが発生しました。\n'
                        '$e';
                    talker.error(e);
                    showRetry.value = true;
                  }
                },
                label: const Text('ダウンロード (約1MB)'),
                icon: const Icon(Icons.file_download),
              )
            else
              const Text('ダウンロードが正常に終了しました'),
            if (showRetry.value)
              FloatingActionButton.extended(
                onPressed: () async {
                  isDownloading.value = true;
                  showRetry.value = false;
                  downloadingStatus.value = '開始しています...';
                  try {
                    await Dio().download(
                      'https://api.dmdata.jp/v2/parameter/earthquake/station',
                      '${ref.read(applicationSupportDirectoryProvider).path}/parameter-earthquake.json',
                      onReceiveProgress: (received, total) {
                        downloadingStatus.value =
                            'ファイル1/2をダウンロード中... (${(received / 1024).toStringAsFixed(1)}KB)';
                      },
                      options: Options(
                        headers: {
                          'Authorization':
                              'Basic ${base64.encode(utf8.encode(Env.dmdataKey))}',
                          'Referer': 'https://${Env.dmdataOrigin}/',
                        },
                      ),
                    );
                    downloadingStatus.value = 'ファイル1/2のダウンロード完了... ';
                    await Dio().download(
                      'https://raw.githubusercontent.com/EQMonitor/EQMonitor/main/public/arv.json',
                      '${ref.read(applicationSupportDirectoryProvider).path}/arv.json',
                      onReceiveProgress: (received, total) {
                        downloadingStatus.value =
                            'ファイル2/2をダウンロード中... (${(received / 1024).toStringAsFixed(1)}KB)';
                      },
                    );
                    downloadingStatus.value = 'ファイル2/2のダウンロード完了... ';
                    // Merge処理
                    final param = await File(
                      '${ref.read(applicationSupportDirectoryProvider).path}/parameter-earthquake.json',
                    ).readAsString();
                    final arv = await File(
                      '${ref.read(applicationSupportDirectoryProvider).path}/arv.json',
                    ).readAsString();
                    final data = ParameterEarthquake.fromTwoJson(
                      json.decode(param) as Map<String, dynamic>,
                      json.decode(arv) as Map<String, dynamic>
                    );
                    await File(
                      '${ref.read(applicationSupportDirectoryProvider).path}/parameter-earthquake-with-arv.json',
                    ).writeAsString(json.encode(data));

                    isFinished.value = true;
                    isDownloading.value = false;
                    // 初期化済みフラグを立てる
                    await ref
                        .read(sharedPreferencesProvder)
                        .setBool('isInitializated', true);
                  } on DioError catch (e) {
                    downloadingStatus.value = 'ダウンロード中にエラーが発生しました。\n'
                        '${e.message}\n'
                        '${e.response?.data}';
                    talker.error(e.response?.data);
                    showRetry.value = true;
                  } on Error catch (e) {
                    downloadingStatus.value = 'エラーが発生しました。\n'
                        '$e';
                    talker.error(e);
                    showRetry.value = true;
                  }
                },
                label: const Text('ダウンロード (約1MB)'),
                icon: const Icon(Icons.file_download),
              ),
          ],
        ),
      ),
      floatingActionButton: (isFinished.value)
          ? FloatingActionButton.extended(
              onPressed: () async {
                await Restart.restartApp();
              },
              label: const Text('次へ進む'),
              icon: const Icon(Icons.arrow_forward),
            )
          : null,
    );
  }
}
