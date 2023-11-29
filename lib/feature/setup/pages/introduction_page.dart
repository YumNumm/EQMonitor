import 'package:eqmonitor/core/component/button/action_button.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          child: ActionButton.text(
            context: context,
            text: 'クイックガイドを開始',
            onPressed: onNext,
          ),
        ),
        // このボタンを押して、利用規約とプライバシーポリシーに同意したものとみなします。
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'クイックガイドを開始することで、 ',
                  ),
                  TextSpan(
                    text: '利用規約',
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => context.push(
                            const TermOfServiceRoute($extra: null).location,
                          ),
                  ),
                  const TextSpan(
                    text: ' と ',
                  ),
                  TextSpan(
                    text: 'プライバシーポリシー',
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => context.push(
                            const PrivacyPolicyRoute($extra: null).location,
                          ),
                  ),
                  const TextSpan(
                    text: ' に同意したものとみなします。',
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );

    return body;
  }
}
