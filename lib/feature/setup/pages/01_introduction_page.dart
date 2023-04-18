import 'package:eqmonitor/common/component/button/action_button.dart';
import 'package:eqmonitor/feature/setup/component/background_image.dart';
import 'package:flutter/material.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({
    required this.onNext,
    super.key,
  });

  final void Function() onNext;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final body = Column(
      children: [
        // アプリアイコン
        const Padding(
          padding: EdgeInsets.all(16),
          child: SizedBox(
            width: 100,
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(800)),
              child: Image(
                image: AssetImage('assets/images/icon.png'),
              ),
            ),
          ),
        ),
        // 画面上部のタイトル
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'EQMonitorへようこそ',
            style: theme.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const Spacer(),
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
                    'クイックガイドを開始',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );

    return SetupBackgroundImageWidget(child: body);
  }
}
