import 'dart:ui';

import 'package:eqmonitor/common/component/button/action_button.dart';
import 'package:eqmonitor/common/component/container/blur_container.dart';
import 'package:flutter/material.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({
    required this.onNext,
    super.key,
  });

  final void Function() onNext;

  @override
  Widget build(BuildContext context) {
    final body = Column(
      children: [
        // 画面上部のタイトル
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'EQMonitor',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const Spacer(),
        const BlurContainer(
          child: Padding(
            padding: EdgeInsets.all(100),
            child: Text('EQMonitor'),
          ),
        ),
        // 画面下部のボタン
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
                    'はじめる',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );

    return Scaffold(
      body: DecoratedBox(
        // 背景に画像を設定
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/setup-bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        // 背景をぼかす
        child: SizedBox.expand(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: SafeArea(child: body),
          ),
        ),
      ),
    );
  }
}
