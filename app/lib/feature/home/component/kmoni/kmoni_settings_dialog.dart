import 'package:eqmonitor/core/provider/kmoni/provider/kmoni_color_provider.dart';
import 'package:eqmonitor/core/provider/kmoni/viewmodel/kmoni_settings.dart';
import 'package:eqmonitor/feature/home/component/kmoni/kmoni_scale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class KmoniSettingsDialogWidget extends HookConsumerWidget {
  const KmoniSettingsDialogWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(kmoniSettingsProvider);
    final colorMap = ref.watch(kyoshinColorMapProvider);
    final (min, max) = (colorMap.first, colorMap.last);

    final currentState = useState(state.minRealtimeShindo ?? min.intensity);
    final theme = Theme.of(context);
    return AlertDialog(
      title: const Text('強震モニタの設定'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('閉じる'),
        ),
      ],
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text(
                '表示する最低リアルタイム震度',
              ),
              subtitle: Column(
                children: [
                  const SizedBox(
                    height: 30,
                    child: KmoniScaleWidget(
                      showText: false,
                    ),
                  ),
                  SliderTheme(
                    data: theme.sliderTheme.copyWith(
                      trackShape: _CustomTrackShape(),
                    ),
                    child: Slider(
                      onChangeEnd: (value) => ref
                          .read(kmoniSettingsProvider.notifier)
                          .setMinRealtimeShindo(
                            value: value,
                          ),
                      min: min.intensity,
                      max: max.intensity,
                      value: currentState.value,
                      onChanged: (value) => currentState.value = value,
                    ),
                  ),
                ],
              ),
            ),
            SwitchListTile.adaptive(
              value: state.showRealtimeShindoScale,
              onChanged: (value) => ref
                  .read(kmoniSettingsProvider.notifier)
                  .setShowRealtimeShindoScale(
                    value: value,
                  ),
              title: const Text('リアルタイム震度のスケールを表示'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
