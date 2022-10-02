import 'package:eqmonitor/view/introduction_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          ref.read(introductionController).jumpToPage(1);
        },
        label: const Text('次へ進む'),
        icon: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
