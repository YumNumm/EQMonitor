import 'package:eqmonitor/core/component/button/action_button.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/fcm/notification_controller.dart';
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
            // 画面上部のタイトル
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                '通知について',
                style: theme.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer(),
            BorderedContainer(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  // notification icon
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.notifications_active,
                        color: Colors.redAccent,
                        size: 32,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      '地震に関する情報をお伝えするために、通知権限を許可してください',
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            ActionButton.text(
              onPressed: () => NotificationController.requestPermission().then(
                (value) => onNext(),
              ),
              text: '通知を許可する',
              context: context,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: onNext,
              child: const Text('拒否する'),
            ),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
