// Evidence copy failures include expected StateErrors from fail-closed gates.
// ignore_for_file: avoid_catches_without_on_clauses

import 'dart:async';

import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_spike_controller.dart';
import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_spike_remount_owner.dart';
import 'package:eqmonitor_map/src/flutter_scene/spike_label_painter.dart';
import 'package:eqmonitor_map/src/observability/scene_spike_gate.dart';
import 'package:eqmonitor_map/src/observability/scene_spike_observation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_scene/scene.dart' as scene;
import 'package:vector_math/vector_math_64.dart';

class SceneSpikeBindingObserver with WidgetsBindingObserver {
  const SceneSpikeBindingObserver({
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
      case AppLifecycleState.resumed:
        onForeground();
      case AppLifecycleState.inactive ||
          AppLifecycleState.paused ||
          AppLifecycleState.detached ||
          AppLifecycleState.hidden:
        onBackground();
    }
  }
}

class FlutterSceneSpikeView extends HookWidget {
  const FlutterSceneSpikeView({required this.remountOwner, super.key});

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
      controller
        ..attach(
          logicalSize: logicalSize,
          devicePixelRatio: devicePixelRatio,
        )
        ..recordTextPainterOverlay();
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
  const _SceneSpikeHarnessPanel({required this.remountOwner});

  // The owner exposes its current controller to the internal spike harness.
  // ignore: diagnostic_describe_all_properties
  final FlutterSceneSpikeRemountOwner remountOwner;

  @override
  Widget build(BuildContext context) {
    final controller = remountOwner.controller;
    final capabilities = controller.capabilityResults();
    final identity = controller.runtimeIdentity;
    final manifest = controller.buildManifest;
    final performance = controller.performance;
    final frameworkRevision = manifest?.flutterFrameworkRevision ?? 'missing';
    final engineRevision = manifest?.flutterEngineRevision ?? 'missing';
    final engineContentHash = manifest?.flutterEngineContentHash ?? 'missing';
    final dartVersion = identity?.dartVersion ?? 'unavailable';
    final dartSourceRevision = manifest?.dartSourceRevision ?? 'missing';
    final operatingSystemVersion =
        identity?.operatingSystemVersion ?? 'OS unavailable';
    final sceneRevision = manifest?.flutterSceneRevision ?? 'missing';
    final rendererRevision =
        manifest?.eqmonitorMapRendererRevision ?? 'missing';
    final rendererDirty = manifest == null
        ? 'missing'
        : '${manifest.eqmonitorMapRendererCheckoutDirty}';
    return Material(
      color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.94),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.52,
          child: ListView.builder(
            itemCount: capabilities.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '${identity?.run.platform.name ?? 'unsupported'} / '
                        '${identity?.run.buildMode.name ?? 'unsupported'} · '
                        '${identity?.deviceModel ?? 'device unavailable'} · '
                        '$operatingSystemVersion',
                      ),
                      Text(
                        'Flutter $frameworkRevision\n'
                        'Engine $engineRevision\n'
                        'Engine artifact $engineContentHash\n'
                        'Dart $dartVersion ($dartSourceRevision)\n'
                        'Scene $sceneRevision\n'
                        'Renderer $rendererRevision dirty=$rendererDirty',
                      ),
                      if (controller.metadataFailure case final failure?)
                        Text(
                          failure,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Attest renderer backend'),
                        value: controller.renderingBackend,
                        items: [
                          for (final backend
                              in controller.backendAttestationOptions())
                            DropdownMenuItem(
                              value: backend,
                              child: Text(backend),
                            ),
                        ],
                        onChanged: (backend) {
                          if (backend != null) {
                            controller.attestRenderingBackend(backend);
                          }
                        },
                      ),
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
                          OutlinedButton(
                            onPressed: controller.resetEvidence,
                            child: const Text('Reset evidence'),
                          ),
                          OutlinedButton(
                            onPressed: () async {
                              try {
                                final json = await controller
                                    .canonicalEvidenceJson();
                                await Clipboard.setData(
                                  ClipboardData(text: json),
                                );
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Canonical JSON copied.'),
                                    ),
                                  );
                                }
                              } catch (_) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Evidence could not be copied. '
                                        'Review the capability status.',
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text('Copy canonical JSON'),
                          ),
                        ],
                      ),
                      if (controller.runStartFailure case final failure?)
                        Text(
                          failure,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      Text(
                        'frames=${controller.frameCount} '
                        'partial=${controller.partialUpdateCount} '
                        'resume=${controller.lifecycleResumeCount} '
                        'remount=${controller.disposeAndRemountCount} '
                        'appRebuild=${performance.resourceRebuildCount} '
                        'exceptions=${performance.exceptionCount}',
                      ),
                    ],
                  ),
                );
              }
              final result = capabilities[index - 1];
              final mayAttest =
                  SceneSpikeEvidenceContract.requiredProvenance(
                    result.capability,
                  ) ==
                  .operatorAttestation;
              if (!mayAttest) {
                return _SceneSpikeCapabilityStatusRow(result: result);
              }
              return _SceneSpikeOperatorChecklistTile(
                controller: controller,
                result: result,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SceneSpikeCapabilityStatusRow extends StatelessWidget {
  const _SceneSpikeCapabilityStatusRow({required this.result});

  // The result is rendered directly in the internal spike harness.
  // ignore: diagnostic_describe_all_properties
  final SceneSpikeCapabilityResult result;

  @override
  Widget build(BuildContext context) => ListTile(
    dense: true,
    leading: Icon(
      switch (result.status) {
        .passed => Icons.check_circle,
        .failed => Icons.error,
        .unobserved => Icons.radio_button_unchecked,
      },
    ),
    title: Text(result.capability.name),
    subtitle: Text(
      '${result.status.name} · ${result.provenance.name}\n${result.detail}',
    ),
  );
}

class _SceneSpikeOperatorChecklistTile extends StatelessWidget {
  const _SceneSpikeOperatorChecklistTile({
    required this.controller,
    required this.result,
  });

  // The controller is scoped to the internal spike harness.
  // ignore: diagnostic_describe_all_properties
  final FlutterSceneSpikeController controller;
  // The result is rendered directly in the internal spike harness.
  // ignore: diagnostic_describe_all_properties
  final SceneSpikeCapabilityResult result;

  @override
  Widget build(BuildContext context) {
    final capability = result.capability;
    final criteria = controller.checklistCriteria(capability);
    final checklistLocked =
        result.status == .passed || result.status == .failed;
    return ExpansionTile(
      leading: Icon(
        switch (result.status) {
          .passed => Icons.check_circle,
          .failed => Icons.error,
          .unobserved => Icons.fact_check_outlined,
        },
      ),
      title: Text(capability.name),
      subtitle: Text(
        '${result.status.name} · ${result.provenance.name}\n${result.detail}',
      ),
      children: [
        for (final criterion in criteria)
          CheckboxListTile(
            dense: true,
            value: controller.isChecklistCriterionCompleted(
              capability: capability,
              criterionId: criterion.id,
            ),
            onChanged: checklistLocked
                ? null
                : (isCompleted) => controller.setChecklistCriterion(
                    capability: capability,
                    criterionId: criterion.id,
                    isCompleted: isCompleted ?? false,
                  ),
            title: Text(criterion.label),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Align(
            alignment: Alignment.centerRight,
            child: FilledButton.tonal(
              onPressed: controller.canAttestCapability(capability)
                  ? () => controller.attestCapability(capability)
                  : null,
              child: const Text('Attest completed checklist'),
            ),
          ),
        ),
      ],
    );
  }
}
