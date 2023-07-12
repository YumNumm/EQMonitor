import 'package:eqmonitor/core/component/button/action_button.dart';
import 'package:eqmonitor/feature/setup/component/background_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NotificationSettingPage extends HookWidget {
  const NotificationSettingPage({required this.onNext, super.key});
  final void Function() onNext;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SetupBackgroundImageWidget(
        child: Column(
          children: [
            // アプリアイコン
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(800)),
                  child: Image(
                    image: AssetImage('assets/images/icon.png'),
                  ),
                ),
              ),
            ),
            // 画面上部のタイトル
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'EQMonitorへようこそ',
                style: theme.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ActionButton(
                isEnabled: true,
                onPressed: onNext,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        '始める',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
