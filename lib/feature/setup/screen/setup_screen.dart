import 'dart:async';

import 'package:eqmonitor/common/provider/shared_preferences.dart';
import 'package:eqmonitor/common/router/router.dart';
import 'package:eqmonitor/feature/setup/pages/01_introduction_page.dart';
import 'package:eqmonitor/feature/setup/pages/03_notification_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../pages/02_quick_guide_about_eew.dart';

class SetupScreen extends HookConsumerWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    void next() {
      pageController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }

    final pages = <Widget>[
      IntroductionPage(
        onNext: next,
      ),
      QuickGuideAboutEewPage(
        onNext: next,
      ),
      NotificationSettingPage(
        onNext: () async {
          unawaited(
            ref.read(sharedPreferencesProvider).setBool('isInitialized', true),
          );
          const DebugHomeRoute().pushReplacement(context);
        },
      ),
    ];
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      itemCount: pages.length,
      itemBuilder: (context, index) {
        // pages配列内にWidgetがある場合はそれを返す
        if (pages.length > index) {
          return pages[index];
        }
        throw Exception('Invalid index: $index');
      },
    );
  }
}
