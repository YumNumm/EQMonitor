import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

mixin MapLayer<D1, D2> on HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInitialized = useRef(false);
    final controller = MapController.of(context);
    useEffect(() {
      unawaited(
        WidgetsBinding.instance.endOfFrame.then((_) {
          if (context.mounted) {
            initialize(
              controller,
              dataDependencies(ref),
              layerDependencies(ref),
            );
            isInitialized.value = true;
            onLayerUpdated(controller, layerDependencies(ref));
          }
        }),
      );
      return () async => dispose();
    }, []);

    final state = dataDependencies(ref);
    useEffect(() {
      print(state.runtimeType);
      if (isInitialized.value) {
        unawaited(onDataUpdated(controller, state));
      }
      return null;
    }, [state]);

    return const SizedBox.shrink();
  }

  Future<void> initialize(MapController controller, D1 data, D2 settings);
  D1 dataDependencies(WidgetRef ref);
  Future<void> onDataUpdated(MapController controller, D1 state);

  D2 layerDependencies(WidgetRef ref);
  Future<void> onLayerUpdated(MapController controller, D2 state);
  Future<void> dispose();

  String? get layerId;
  String? get sourceId;
}
