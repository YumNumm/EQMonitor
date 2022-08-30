import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eqmonitor/private/keys.dart';
import 'package:eqmonitor/provider/init/application_support_dir.dart';
import 'package:eqmonitor/provider/init/shared_preferences.dart';
import 'package:eqmonitor/provider/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:restart_app/restart_app.dart';

import 'setting/term_of_service.dart';

final introductionController =
    Provider<PageController>((ref) => PageController());

class IntroductionPage extends HookConsumerWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView(
      controller: ref.watch(introductionController),
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        WelcomeWidget(),
        TermOfServicePage(showAcceptButton: true),
        FilesDownloadWidget(),
      ],
    );
  }
}

class WelcomeWidget extends ConsumerWidget {
  const WelcomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 6, 0, 60),
              Color.fromARGB(255, 0, 57, 183),
            ],
          ),
        ),
        child: Center(child: Image.asset('assets/header-transparent.png')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          ref.read(introductionController).jumpToPage(1);
        },
        label: const Text('次へ進む'),
        icon: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

class FilesDownloadWidget extends HookConsumerWidget {
  const FilesDownloadWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFinished = useState<bool>(false);
    final isDownloading = useState<bool>(false);
    final downloadingStatus = useState<String>('0%');
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
                  downloadingStatus.value = '開始しています...';
                  try {
                    await Dio().download(
                      'https://api.dmdata.jp/v2/parameter/earthquake/station',
                      '${ref.read(applicationSupportDirectoryProvider).path}/parameter-earthquake.json',
                      onReceiveProgress: (received, total) {
                        print('$received/$total');
                        downloadingStatus.value =
                            'ファイル1/2をダウンロード中... (${received / 1024}KB)';
                      },
                      options: Options(
                        headers: {
                          'Authorization':
                              'Basic ${base64.encode(utf8.encode(dmdataKey))}',
                          'Referer': 'https://sub.example.com/',
                        },
                      ),
                    );
                    downloadingStatus.value = 'ファイル1/2のダウンロード完了... ';
                    await Dio().download(
                      'https://raw.githubusercontent.com/EQMonitor/EQMonitor/main/public/arv.json',
                      '${ref.read(applicationSupportDirectoryProvider).path}/arv.json',
                      onReceiveProgress: (received, total) {
                        print('$received/$total');
                        downloadingStatus.value =
                            'ファイル2/2をダウンロード中... (${received / 1024}KB)';
                      },
                      options: Options(
                        headers: {
                          'Authorization':
                              'Basic ${base64.encode(utf8.encode(dmdataKey))}',
                          'Referer': 'https://sub.example.com/',
                        },
                      ),
                    );
                    downloadingStatus.value = 'ファイル2/2のダウンロード完了... ';
                    isFinished.value = true;
                    isDownloading.value = false;
                  } on DioError catch (e) {
                    downloadingStatus.value = 'ダウンロード中にエラーが発生しました。\n'
                        '${e.message}\n'
                        '${e.response?.data}';
                    ref.read(loggerProvider).wtf(e.response?.data);
                  }
                },
                label: const Text('ダウンロード (約1MB)'),
                icon: const Icon(Icons.file_download),
              )
            else
              const Text('ダウンロードが正常に終了しました')
          ],
        ),
      ),
      floatingActionButton: (isFinished.value)
          ? FloatingActionButton.extended(
              onPressed: () async {
                // 初期化済みフラグを立てる
                await ref
                    .read(sharedPreferencesProvder)
                    .setBool('isInitializated', true);
                await Restart.restartApp();
              },
              label: const Text('次へ進む'),
              icon: const Icon(Icons.arrow_forward),
            )
          : null,
    );
  }
}
