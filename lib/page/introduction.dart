import 'package:eqmonitor/page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
      children: [
        const WelcomeWidget(),
        const TermOfServicePage(showAcceptButton: true),
        Container(
          color: const Color.fromARGB(255, 0, 46, 83),
          child: Center(
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (context) => const MainPage(),
                  ),
                );
              },
              label: const Text('進む'),
            ),
          ),
        ),
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
          await ref.read(introductionController).animateToPage(
                1,
                duration: const Duration(milliseconds: 100),
                curve: Curves.bounceOut,
              );
        },
        label: const Text('次へ進む'),
        icon: const Icon(Icons.arrow_forward),
        backgroundColor: Colors.white,
      ),
    );
  }
}
