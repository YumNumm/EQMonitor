import 'package:eqapi_schema/model/lat_lng.dart';
import 'package:eqmonitor/common/component/map/map.dart';
import 'package:eqmonitor/common/component/map/view_model/map_viemwodel.dart';
import 'package:eqmonitor/common/feature/map/provider/map_data_provider.dart';
import 'package:eqmonitor/feature/home/component/map/kmoni_map_widget.dart';
import 'package:eqmonitor/feature/home/providers/kmoni/viewmodel/kmoni_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeView extends HookConsumerWidget {
  HomeView({super.key});
  final mapKey = GlobalKey(debugLabel: 'HomeView');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mapDataProvider);
    if (state.projectedData == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }

    final moveController = useAnimationController();
    final scaleController = useAnimationController();
    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame.then((_) {
          ref.read(mapDataProvider.notifier).initialize().then((value) {
            ref.read(mapViewModelProvider(mapKey).notifier)
              ..registerWidgetSize(
                context.size!,
              )
              ..registerAnimationControllers(
                moveController: moveController,
                scaleController: scaleController,
              )
              ..fitBounds([
                const LatLng(45.3, 145.1),
                const LatLng(30, 128.8),
              ]);
          });

          ref.read(kmoniViewModelProvider.notifier).initialize();
        });
        return null;
      },
      [],
    );

    return Scaffold(
      body: Stack(
        children: [
          // background
          Container(
            color: const Color.fromARGB(255, 179, 230, 255),
          ),
          ClipRRect(
            child: Stack(
              children: [
                BaseMapWidget(mapKey: mapKey),
                KmoniMapWidget(mapKey: mapKey),
              ],
            ),
          ),
          MapTouchHandlerWidget(mapKey: mapKey),
        ],
      ),
    );
  }
}
