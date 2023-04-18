import 'package:flutter/material.dart';

class EarthquakeRestrictionWidget extends StatelessWidget {
  const EarthquakeRestrictionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final earthquakeImageWidget = Padding(
      padding: const EdgeInsets.all(16),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.all(
            color: Colors.white.withOpacity(0.75),
          ),
          color: theme.cardColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: Image.asset('assets/images/earthquake_happened.png'),
          ),
        ),
      ),
    );
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
          Flexible(child: earthquakeImageWidget),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              '・通知が強い揺れの到達に間に合わない可能性があります\n'
              '・予想に大きな誤差が発生する場合があります\n'
              '・予想には誤差が伴います',
              style: textTheme.titleMedium!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
