import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/earthquake/eew_provider.dart';
import '../../../provider/earthquake/kmoni_controller.dart';
import '../../../provider/setting/developer_mode.dart';

class AboutAppViewModel {
  AboutAppViewModel(this.ref);
  final WidgetRef ref;

  /// パスワードのSHA512-hash
  static const String rightPasswordHash =
      '3024d7c8491f94448dc4f38100c514391824ced1fe687346c84396151d411b7b77c538817b4e4916a87dececbdd3561bc8e0afe03363bd5b1e05df7ce6c5b6e7';

  /// 強震モニタのテスト開始
  void startKmoniTest(BuildContext context) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 0,
        channelKey: 'fromdev',
        title: 'テストモードを開始します',
        body: '強震モニタを確認してください',
        fullScreenIntent: true,
        color: const Color.fromARGB(255, 159, 0, 24),
      ),
    );
    GoRouter.of(context).pop();

    ref.read(kmoniProvider.notifier).startTestCase();
    ref.read(eewProvider.notifier).startTestcase();
  }

  /// 開発者向けモードのボタンHandler
  Future<void> onDeveloperModeTilePressed(BuildContext context) async {
    final isDeveloperModeEnabled = ref.read(developerModeProvider).isDeveloper;
    if (isDeveloperModeEnabled) {
      // 既に有効 -> 無効にするかどうか
      final willDisabled = await _showDeveloperModeDisableDialog(context);
      if (willDisabled) {
        await ref
            .read(developerModeProvider.notifier)
            .change(isDeveloper: false);
        await Fluttertoast.showToast(msg: '無効にしました');
      }
    } else {
      // 無効 -> 有効にするかどうか
      final willEnabled = await _showDeveloperModeEnableDialog(context);
      if (willEnabled) {
        // パスワードによる検証を行う
        // ignore: use_build_context_synchronously
        final password = await _showPasswordDialog(context);
        if (password != null) {
          final isTruePassword = _isTruePassword(password);
          if (isTruePassword) {
            await ref
                .read(developerModeProvider.notifier)
                .change(isDeveloper: true);
            await Fluttertoast.showToast(msg: '有効にしました');
            return;
          }
        } else {
          await Fluttertoast.showToast(msg: 'パスワードが違います');
        }
      }
    }
  }

  bool _isTruePassword(String password) {
    final hash = sha512.convert(utf8.encode(password)).toString();
    return hash == rightPasswordHash;
  }

  /// 開発者向けパスワード入力ダイアログを表示する
  Future<String?> _showPasswordDialog(BuildContext context) async =>
      showDialog<String>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: TextField(
              autofocus: true,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Developer Keyを入力してください',
              ),
              onSubmitted: (password) {
                Navigator.of(context).pop(password);
              },
            ),
          );
        },
      );

  /// 開発者向けモードを無効にするかどうかを確認するダイアログ
  Future<bool> _showDeveloperModeDisableDialog(BuildContext context) async {
    final userInputValue = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('Developer Modeを無効にしますか？'),
          actions: [
            ElevatedButton(
              child: const Text('キャンセル'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
    return userInputValue ?? false;
  }

  /// 開発者向けモードを有効にするかどうかを確認するダイアログ
  Future<bool> _showDeveloperModeEnableDialog(BuildContext context) async {
    final userInputValue = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('Developer Modeを有効にしますか？'),
          actions: [
            ElevatedButton(
              child: const Text('キャンセル'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
    return userInputValue ?? false;
  }
}
