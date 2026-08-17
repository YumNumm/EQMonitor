import 'dart:async';

import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_spike_remount_owner.dart';
import 'package:eqmonitor_map/src/flutter_scene/spike_label_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_scene/scene.dart' as scene;
import 'package:vector_math/vector_math_64.dart';

class SceneSpikeBindingObserver with WidgetsBindingObserver {
  const new({
    required this.onMetricsChanged,
    required this.onBackground,
    required this.onForeground,
  });

  final VoidCallback onMetricsChanged;
  final VoidCallback onBackground;
  final VoidCallback onForeground;

  @override
  void didChangeMetrics() {
    onMetricsChanged();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case .resumed:
        onForeground();
      case .inactive || .paused || .detached || .hidden:
        onBackground();
    }
  }
}

class FlutterSceneSpikeView extends HookWidget {
  const new({required this.remountOwner, super.key});

  // The owner exposes its current controller to the internal spike harness.
  // ignore: diagnostic_describe_all_properties
  final FlutterSceneSpikeRemountOwner remountOwner;

  @override
  Widget build(BuildContext context) {
    useListenable(remountOwner);
    final controller = remountOwner.controller;
    useListenable(controller);
    final metricsEpoch = useState(0);
    final logicalSize = MediaQuery.sizeOf(context);
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    final observer = useMemoized(
      () => SceneSpikeBindingObserver(
        onMetricsChanged: () => metricsEpoch.value += 1,
        onBackground: controller.background,
        onForeground: controller.foreground,
      ),
      [controller],
    );
    useEffect(() {
      final binding = WidgetsBinding.instance;
      binding
        ..addObserver(observer)
        ..addTimingsCallback(controller.recordFrameTimings);
      controller.attach(
        logicalSize: logicalSize,
        devicePixelRatio: devicePixelRatio,
      );
      remountOwner.confirmMounted(controller: controller);
      unawaited(controller.initializeStaticResources());
      return () {
        binding
          ..removeTimingsCallback(controller.recordFrameTimings)
          ..removeObserver(observer);
        controller.detach();
      };
    }, [controller, observer, remountOwner]);

    useEffect(
      () {
        if (controller.lifecycle.phase == .rebuilding) {
          unawaited(controller.completePendingAppResourceRebuild());
        }
        return null;
      },
      [
        controller,
        controller.lifecycle.phase,
        controller.lifecycle.appResourceGeneration,
      ],
    );

    useEffect(() {
      controller.resize(
        logicalSize: logicalSize,
        devicePixelRatio: devicePixelRatio,
      );
      return null;
    }, [controller, logicalSize, devicePixelRatio, metricsEpoch.value]);

    useEffect(() {
      if (!controller.isUpdating) {
        return null;
      }
      final timer = Timer.periodic(
        const Duration(milliseconds: 100),
        (_) => controller.updatePartialMesh(),
      );
      return timer.cancel;
    }, [controller, controller.isUpdating]);

    return LayoutBuilder(
      builder: (context, constraints) {
        final sceneSize = constraints.biggest;
        return Stack(
          children: [
            Positioned.fill(
              child: scene.SceneView(
                controller.sceneGraph,
                camera: controller.camera,
                autoTick: controller.lifecycle.mayTick,
              ),
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: SpikeLabelPainter(
                    projectionMatrix: controller.projectionMatrixFor(
                      sceneSize,
                    ),
                    geographicAnchor: Vector3(0, 0.72, 0),
                    logicalSize: sceneSize,
                    devicePixelRatio: devicePixelRatio,
                    label: 'EQMonitor overlay',
                    style:
                        Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.surface.withValues(alpha: 0.8),
                        ) ??
                        const TextStyle(),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _SceneSpikeHarnessPanel(remountOwner: remountOwner),
            ),
          ],
        );
      },
    );
  }
}

class _SceneSpikeHarnessPanel extends StatelessWidget {
  const new({required this.remountOwner});

  // The owner exposes its current controller to the internal spike harness.
  // ignore: diagnostic_describe_all_properties
  final FlutterSceneSpikeRemountOwner remountOwner;

  @override
  Widget build(BuildContext context) {
    final controller = remountOwner.controller;
    return Material(
      color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.94),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilledButton(
                    onPressed: controller.isUpdating
                        ? controller.stopUpdates
                        : controller.startUpdates,
                    child: Text(
                      controller.isUpdating
                          ? 'Stop partial updates'
                          : 'Start partial updates',
                    ),
                  ),
                  OutlinedButton(
                    onPressed: controller.requestAppResourceRebuild,
                    child: const Text('Rebuild app resources'),
                  ),
                  OutlinedButton(
                    onPressed: remountOwner.requestRemount,
                    child: const Text('Dispose and remount'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 4,
                children: [
                  Text('frames=${controller.frameCount}'),
                  Text('partial=${controller.partialUpdateCount}'),
                  Text('resume=${controller.lifecycleResumeCount}'),
                  Text('remount=${controller.disposeAndRemountCount}'),
                  Text('appRebuild=${controller.resourceRebuildCount}'),
                  Text('exceptions=${controller.exceptionCount}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
