import 'package:eqmonitor/feature/home/component/kmoni/kmoni_scale.dart';
import 'package:eqmonitor/feature/home/features/kmoni/page/kmoni_settings_page.dart';
import 'package:eqmonitor/feature/home/features/kmoni/provider/kmoni_color_provider.dart';
import 'package:eqmonitor/feature/home/features/kmoni/viewmodel/kmoni_settings.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class KmoniSettingsModal extends HookConsumerWidget {
  const KmoniSettingsModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(kmoniSettingsProvider);
    final theme = Theme.of(context);

    final barWidget = Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 36,
      height: 4,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: theme.colorScheme.onSurface,
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 12),
        ],
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        barWidget,
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const KmoniSettingsUseToggle(),
                  if (state.useKmoni) const KmoniSettingsDialogInside(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class KmoniSettingsDialogInside extends ConsumerWidget {
  const KmoniSettingsDialogInside({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(kmoniSettingsProvider);
    final colorMap = ref.watch(kyoshinColorMapProvider);
    final (min, max) = (colorMap.first, colorMap.last);
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text('リアルタイム震度の表示しきい値'),
          subtitle: SliderTheme(
            data: theme.sliderTheme.copyWith(
              trackShape: _CustomTrackShape(),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                    child: KmoniScaleWidget(
                      showText: false,
                      markers: [
                        if (state.minRealtimeShindo != null &&
                            state.minRealtimeShindo != -3.0)
                          state.minRealtimeShindo!,
                      ],
                      position: KmoniIntensityPosition.under,
                    ),
                  ),
                  Slider(
                    min: min.intensity,
                    max: max.intensity,
                    value: state.minRealtimeShindo ?? min.intensity,
                    onChanged: (value) => ref
                        .read(kmoniSettingsProvider.notifier)
                        .setMinRealtimeShindo(
                          value: value,
                        ),
                  ),
                ],
              ),
            ),
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
        SwitchListTile.adaptive(
          title: const Text('現在地のマーカーを表示する'),
          value: state.showCurrentLocationMarker,
          onChanged: (value) async {
            await ref
                .read(kmoniSettingsProvider.notifier)
                .setShowCurrentLocationMarker(
                  value: value,
                );
            ref.invalidate(locationStreamProvider);
          },
        ),
        ListTile(
          title: const Text('観測点の枠表示モード'),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: DropdownMenu(
              initialSelection: state.kmoniMarkerType,
              onSelected: (value) =>
                  ref.read(kmoniSettingsProvider.notifier).setMarkerType(
                        type: value!,
                      ),
              dropdownMenuEntries: [
                for (final type in KmoniMarkerType.values)
                  DropdownMenuEntry(
                    value: type,
                    label: switch (type) {
                      KmoniMarkerType.always => '常に枠を表示する',
                      KmoniMarkerType.onlyEew => '緊急地震速報発表時のみ',
                      KmoniMarkerType.never => '枠を表示しない',
                    },
                  ),
              ],
            ),
          ),
        ),
      ],
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
