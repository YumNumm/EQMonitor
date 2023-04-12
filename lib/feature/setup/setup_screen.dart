import 'package:eqmonitor/feature/setup/pages/introduction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SetupScreen extends HookConsumerWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
          case 1:
            return IntroductionPage(
              onNext: () => pageController.nextPage(
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeIn,
              ),
            );
          default:
            throw Exception('Invalid index: $index');
        }
      },
    );
  }
}
