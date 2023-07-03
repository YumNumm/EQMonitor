import 'package:eqmonitor/common/component/map/view_model/map_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// タッチ操作をハンドルするWidget
/// mapViewModelProviderからMapStateを取得すること
class MapTouchHandlerWidget extends HookConsumerWidget {
  const MapTouchHandlerWidget({super.key, required this.mapKey});

  final Key mapKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widget = Listener(
      onPointerSignal:
          ref.read(mapViewModelProvider(mapKey).notifier).recievedPointerSignal,
      child: GestureDetector(
        onScaleUpdate:
            ref.read(mapViewModelProvider(mapKey).notifier).handleScaleUpdate,
        onScaleStart:
            ref.read(mapViewModelProvider(mapKey).notifier).handleScaleStart,
        onScaleEnd:
            ref.read(mapViewModelProvider(mapKey).notifier).handleScaleEnd,
      ),
    );
    return widget;
  }
}
