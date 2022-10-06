import 'package:eqmonitor/provider/init/device_info.dart';
import 'package:eqmonitor/provider/package_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AboutWidget extends HookConsumerWidget {
  const AboutWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceInfo = ref.watch(androidDeviceInfoProvider);
    const descriptionTextStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );
    const titleTextStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      title: const Text(
        'アプリ情報',
        style: titleTextStyle,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <List<Widget>>[
          ref.watch(packageInfoProvider).when<List<Widget>>(
                data: (packageInfo) => <Widget>[
                  Text(
                    'バージョン: ${packageInfo.version}',
                    style: descriptionTextStyle,
                  ),
                  Text(
                    'ビルド: ${packageInfo.buildNumber}',
                    style: descriptionTextStyle,
                  ),
                  Text(
                    'パッケージ名: ${packageInfo.packageName}',
                    style: descriptionTextStyle,
                  ),
                ],
                error: (error, stackTrace) => [Text(error.toString())],
                loading: () => const [Text('Loading...')],
              ),
          <Widget>[
            Text(
              'OS: Android${deviceInfo.version.release} (SDK${deviceInfo.version.sdkInt})',
              style: descriptionTextStyle,
            ),
            Text(
              'モデル: ${deviceInfo.model}',
              style: descriptionTextStyle,
            ),
            Text(
              'メーカー: ${deviceInfo.manufacturer}',
              style: descriptionTextStyle,
            ),
          ],
        ].expand((e) => e).toList(),
      ),
      onTap: () => ref.watch(packageInfoProvider).hasValue
          ? () {
              Clipboard.setData(
                ClipboardData(
                  text: () {
                    final packageInfo = ref.read(packageInfoProvider).value!;
                    return 'バージョン: ${packageInfo.version}\n'
                        'ビルド: ${packageInfo.buildNumber}\n'
                        'パッケージ名: ${packageInfo.packageName}\n'
                        'OS: Android${deviceInfo.version.release} (SDK${deviceInfo.version.sdkInt})\n'
                        'モデル: ${deviceInfo.model}\n'
                        'メーカー: ${deviceInfo.manufacturer}\n';
                  }(),
                ),
              );
              Fluttertoast.showToast(msg: 'クリップボードにコピーしました');
            }
          : null,
    );
  }
}
