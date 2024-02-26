import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:flutter/material.dart';

class KmoniCautionWidget extends StatelessWidget {
  const KmoniCautionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        (
          '防災科研へ本アプリに関する問い合わせを行わないでください',
          '本アプリは防災科研とは無関係に開発しています。\n'
              '防災科研に不具合や意見を送信することは迷惑となりますので、行わないでください。',
        ),
        (
          '強震モニタは防災科研により提供されています',
          '強震モニタは、国立研究開発法人防災科学技術研究所が運用・提供しています。',
        ),
        (
          '事前の予告なしに提供が停止される場合があります',
          '防災科研の都合により、事前の予告なしに提供が終了する場合があります。\n'
              'あらかじめご了承ください',
        ),
        (
          '強震モニタは、揺れの様子を直感的に捉えることを目的としています',
          '強震モニタではリアルタイムで観測値を処理しているため、ノイズや障害により観測値が変動する可能性があります'
        ),
      ]
          .mapIndexed(
            (index, e) => BorderedContainer(
              accentColor:
                  index == 0 ? Colors.redAccent.withOpacity(0.8) : null,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: index == 0
                              ? Colors.white
                              : theme.colorScheme.onPrimaryContainer,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          e.$1,
                          style: theme.textTheme.titleSmall!.copyWith(
                            color: index == 0 ? Colors.white : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 16),
                      Flexible(
                        child: Text(
                          e.$2,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: index == 0 ? Colors.white : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
