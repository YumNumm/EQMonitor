import 'package:eqmonitor/common/component/map/view_model/map_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EewHypocenterWidget extends HookConsumerWidget {
  const EewHypocenterWidget({required this.mapKey, super.key});

  final Key mapKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(MapViewModelProvider(mapKey));
    return Container();
  }
}
