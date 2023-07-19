import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:flutter/material.dart';

class EarthquakeRestrictionWidget extends StatelessWidget {
  const EarthquakeRestrictionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            'デバイスの状態、アプリケーションの状態、ネットワークの状態によっては、通知が届かない場合があります。',
            '通知が強い揺れの到達に間に合わない可能性があります',
            '予想に大きな誤差が発生する場合があります',
            '予想には誤差が伴います'
          ]
              .mapIndexed(
                (index, e) => BorderedContainer(
                  child: Row(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                        child: const SizedBox(
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
              )
              .toList(),
        ),
      ],
    );
  }
}
