import 'dart:async';

import 'package:eqmonitor/feature/map/ui/components/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:synchronized/extension.dart';

mixin MapLayer<D, S> on HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = MapController.of(context);
    if (controller == null) {
      return const SizedBox.shrink();
    }
    useEffect(() {
      unawaited(
        WidgetsBinding.instance.endOfFrame.then((_) async {
          await controller.synchronized(
            () async => initialize(
              controller,
              dataDependency(controller, ref),
              styleDependency(controller, ref),
            ),
          );
        }),
      );
      return () async {
        await controller.synchronized(() async => dispose(controller));
      };
    }, [controller]);

    final data = dataDependency(controller, ref);
    final style = styleDependency(controller, ref);
    useEffect(() {
      unawaited(onDataUpdated(controller, data));
      return null;
    }, [data]);
    useEffect(() {
      unawaited(onStyleUpdated(controller, style));
      return null;
    }, [style]);

    return const SizedBox.shrink();
  }

  Future<void> initialize(MapLibreMapController controller, D data, S style);
  Future<void> dispose(MapLibreMapController controller);
  D dataDependency(MapLibreMapController controller, WidgetRef ref);
  S styleDependency(MapLibreMapController controller, WidgetRef ref);
  Future<void> onDataUpdated(MapLibreMapController controller, D data);
  Future<void> onStyleUpdated(MapLibreMapController controller, S style);
}
