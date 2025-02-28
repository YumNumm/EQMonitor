import 'package:eqmonitor/feature/map/data/model/camera_position.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeMapContent extends HookConsumerWidget {
  const HomeMapContent({
    required this.cameraPosition,
    super.key,
  });

  final MapCameraPosition cameraPosition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SizedBox.shrink();
  }
}
