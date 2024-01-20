import 'dart:typed_data';
import 'dart:ui';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/provider/capture/intensity_icon_render.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IntensityRendererWidget extends HookConsumerWidget {
  const IntensityRendererWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      runSpacing: 4,
      spacing: 4,
      children: [
        for (final intensity in JmaIntensity.values)
          for (final type in [
            IntensityIconType.small,
            IntensityIconType.smallWithoutText,
          ])
            _IntensityRender(
              intensity: intensity,
              onRendered: (data) => switch (type) {
                IntensityIconType.small => ref
                    .read(intensityIconRenderProvider.notifier)
                    .onRendered(data, intensity),
                IntensityIconType.smallWithoutText => ref
                    .read(intensityIconFillRenderProvider.notifier)
                    .onRendered(data, intensity),
                _ => null,
              },
              type: type,
            ),
      ],
    );
  }
}

class _IntensityRender extends HookConsumerWidget {
  _IntensityRender({
    required this.onRendered,
    required this.intensity,
    required this.type,
  }) : super() {
    _key = GlobalObjectKey((intensity, type));
  }

  final void Function(Uint8List data) onRendered;
  final JmaIntensity intensity;
  final IntensityIconType type;

  late final GlobalObjectKey _key;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame.then((_) async {
          final boundary =
              _key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
          final image = await boundary.toImage();
          final byte = await image.toByteData(format: ImageByteFormat.png);
          onRendered.call(byte!.buffer.asUint8List());
        });
        return null;
      },
      [],
    );
    return RepaintBoundary(
      key: _key,
      child: JmaIntensityIcon(
        intensity: intensity,
        type: type,
      ),
    );
  }
}
