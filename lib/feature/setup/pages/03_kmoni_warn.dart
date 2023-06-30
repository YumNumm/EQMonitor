import 'package:collection/collection.dart';
import 'package:eqmonitor/common/component/button/action_button.dart';
import 'package:eqmonitor/feature/setup/component/background_image.dart';
import 'package:flutter/material.dart';

class KmoniWarnPage extends StatelessWidget {
  const KmoniWarnPage({required this.onNext, super.key});
  final void Function() onNext;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SetupBackgroundImageWidget(
        child: Column(
          children: [
            // 画面上部のタイトル
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                '強震モニタについて',
                style: theme.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'EQMonitorでは、国立研究開発法人防災科学技術研究所(防災科研)が運用する強震モニタを利用しています。\n'
                '本アプリの利用に際して、以下の注意を確認してください',
                style: theme.textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            Column(
              children: [
                '防災科研へ本アプリの問い合わせを行わないでください',
                '強震モニタではリアルタイムで観測値を処理しているため、ノイズや障害により観測値が変動する可能性があります',
              ]
                  .mapIndexed(
                    (index, e) => Card(
                      elevation: 0,
                      color: (index == 0) ? Colors.red[900] : theme.cardColor,
                      // border
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: theme.colorScheme.onSurface,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),

                      margin: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            const DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: SizedBox(
                                width: 8,
                                height: 8,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Flexible(
                              child: Text(
                                e,
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const Spacer(),
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
                        '次へ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
