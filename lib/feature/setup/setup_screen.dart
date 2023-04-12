import 'package:eqmonitor/feature/setup/pages/introduction_page.dart';
import 'package:flutter/material.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return const IntroductionPage();
          default:
            throw Exception('Invalid index: $index');
        }
      },
    );
  }
}
