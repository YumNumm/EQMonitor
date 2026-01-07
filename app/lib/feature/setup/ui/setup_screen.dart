import 'package:eqmonitor/core/provider/setup_completed.dart';
import 'package:eqmonitor/core/provider/user_id.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/setup/ui/pages/notification_permission_page.dart';
import 'package:eqmonitor/feature/setup/ui/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SetupScreen extends HookConsumerWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();

    void nextPage() {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }

    Future<void> completeSetup() async {
      // userIdを生成して保存
      await ref.read(userIdProvider.notifier).save(
            DateTime.now().millisecondsSinceEpoch.toString(),
          );
      // 設定完了をマーク
      ref.read(setupCompletedProvider.notifier).markCompleted();
      // ホーム画面へ遷移
      if (context.mounted) {
        const HomeRoute().go(context);
      }
    }

    final pages = <Widget>[
      WelcomePage(onNext: nextPage),
      NotificationPermissionPage(onComplete: completeSetup),
    ];

    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: pages.length,
        itemBuilder: (context, index) => pages[index],
      ),
    );
  }
}
