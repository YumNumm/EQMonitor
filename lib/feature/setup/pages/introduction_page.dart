import 'dart:ui';

import 'package:flutter/material.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({
    this.onNext,
    super.key,
  });

  final void Function()? onNext;

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
        // 画面上部の説明文
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: const Text(
            'Earthquake Monitor',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        // 画面中央の説明文
        Container(
          margin: const EdgeInsets.only(top: 50),
          child: const Text(
            '地震の発生を通知します',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        // 画面下部のボタン
        Container(
          margin: const EdgeInsets.only(top: 50),
          child: ElevatedButton(
            onPressed: () {
              // 画面遷移
              Navigator.pushNamed(context, '/setup');
            },
            child: const Text('はじめる'),
          ),
        ),
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
