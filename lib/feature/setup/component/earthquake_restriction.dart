import 'package:flutter/material.dart';

class EarthquakeRestrictionWidget extends StatelessWidget {
  const EarthquakeRestrictionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withOpacity(0.75),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: theme.cardColor.withOpacity(0.8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '・デバイスの状態、アプリケーションの状態、ネットワークの状態によっては、通知が届かない場合があります。',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  '・通知が強い揺れの到達に間に合わない可能性があります\n'
                  '・予想に大きな誤差が発生する場合があります\n'
                  '・予想には誤差が伴います',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
