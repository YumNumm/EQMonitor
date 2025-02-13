import 'dart:async';

import 'package:eqmonitor/feature/setup/component/background_image.dart';
import 'package:eqmonitor/feature/setup/pages/introduction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SetupScreen extends HookConsumerWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    Future<void> next() async => pageController.nextPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );

    final pages = <Widget>[IntroductionPage(onNext: next)];
    return SetupBackgroundImageWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: PageView.builder(
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
        ),
      ),
    );
  }
}
