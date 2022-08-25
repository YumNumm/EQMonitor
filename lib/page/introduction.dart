import 'package:eqmonitor/page/setting/term_of_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
          color: Colors.blue,
        ),
      ],
    );
  }
}

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/header-dark.png'),
            const SizedBox(height: 16),
            const Text(
              'このアプリは、自分の身体を監視して、自分の身体が悪いときに通知を行うアプリです。',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
