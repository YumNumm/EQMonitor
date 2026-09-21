import 'package:eqmonitor/core/component/expansion/expandable_section.dart';
import 'package:eqmonitor/core/component/selector/controlled_dropdown.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter/material.dart';
import 'package:m3e_core/m3e_core.dart';

const eqmonitorMapGpuProbeAtlasFixtureKey = ValueKey(
  'eqmonitor-map-gpu-probe-atlas-fixture',
);
const eqmonitorMapGpuProbeFaultPointKey = ValueKey(
  'eqmonitor-map-gpu-probe-fault-point',
);
const eqmonitorMapGpuProbeInvalidateGenerationKey = ValueKey(
  'eqmonitor-map-gpu-probe-invalidate-generation',
);

enum _MapGpuFaultSelection {
  none,
  atlasUpload,
  shaderInterface,
  frameSubmit,
}

/// Compile-timeで有効化したFlutter Scene GPU probeだけが表示する操作面。
class EqmonitorMapGpuProbePanel extends StatelessWidget {
  const new({
    required this.atlasFixture,
    required this.faultPoint,
    required this.counterSnapshot,
    required this.onAtlasFixtureChanged,
    required this.onFaultPointChanged,
    required this.onInvalidateRendererContextGeneration,
    super.key,
  });

  final MapSpriteAtlasProbeFixture atlasFixture;
  final MapGpuFaultPoint? faultPoint;
  final MapGpuResourceCounterSnapshot? counterSnapshot;
  final ValueChanged<MapSpriteAtlasProbeFixture> onAtlasFixtureChanged;
  final ValueChanged<MapGpuFaultPoint?> onFaultPointChanged;
  final VoidCallback onInvalidateRendererContextGeneration;

  @override
  Widget build(BuildContext context) {
    final selectedFault = switch (faultPoint) {
      null => _MapGpuFaultSelection.none,
      MapGpuFaultPoint.atlasUpload => _MapGpuFaultSelection.atlasUpload,
      MapGpuFaultPoint.shaderInterface => _MapGpuFaultSelection.shaderInterface,
      MapGpuFaultPoint.frameSubmit => _MapGpuFaultSelection.frameSubmit,
    };
    final generationLabel = switch (counterSnapshot) {
      MapGpuResourceCounterSnapshot(:final rendererContextGeneration) =>
        'Renderer generation: $rendererContextGeneration',
      null => 'Renderer generation: 未取得',
    };
    final counters = switch (counterSnapshot) {
      final snapshot? => [
        (label: 'Texture', counter: snapshot.texture),
        (label: 'Topology', counter: snapshot.topology),
        (label: 'Instance', counter: snapshot.instance),
        (label: 'Node', counter: snapshot.node),
      ],
      null => <({String label, MapGpuResourceKindCounter counter})>[],
    };

    return Align(
      alignment: Alignment.bottomRight,
      child: SafeArea(
        minimum: const EdgeInsets.all(12),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: ListView(
              primary: false,
              shrinkWrap: true,
              children: [
                ExpandableSection(
                  title: const Text('GPU Probe'),
                  subtitle: Text(generationLabel),
                  childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  children: [
                    InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Atlas fixture',
                      ),
                      child: ControlledDropdown<MapSpriteAtlasProbeFixture>(
                        key: eqmonitorMapGpuProbeAtlasFixtureKey,
                        items: MapSpriteAtlasProbeFixture.values
                            .map(
                              (fixture) => M3EDropdownItem(
                                value: fixture,
                                label: switch (fixture) {
                                  MapSpriteAtlasProbeFixture.production =>
                                    'Production',
                                  MapSpriteAtlasProbeFixture.orientation2x2 =>
                                    '2x2 向き確認',
                                  MapSpriteAtlasProbeFixture.alphaHalf =>
                                    'Alpha 50%',
                                  MapSpriteAtlasProbeFixture.edgeBleed =>
                                    'Edge bleed',
                                },
                                selected: fixture == atlasFixture,
                              ),
                            )
                            .toList(growable: false),
                        onSelectionChanged: (selectedItems) {
                          if (selectedItems.isEmpty) return;
                          final value = selectedItems.first.value;
                          onAtlasFixtureChanged(value);
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Fault point',
                      ),
                      child: ControlledDropdown<_MapGpuFaultSelection>(
                        key: eqmonitorMapGpuProbeFaultPointKey,
                        items: _MapGpuFaultSelection.values
                            .map(
                              (selection) => M3EDropdownItem(
                                value: selection,
                                label: switch (selection) {
                                  _MapGpuFaultSelection.none => 'なし',
                                  _MapGpuFaultSelection.atlasUpload =>
                                    'Atlas upload',
                                  _MapGpuFaultSelection.shaderInterface =>
                                    'Shader interface',
                                  _MapGpuFaultSelection.frameSubmit =>
                                    'Frame submit',
                                },
                                selected: selection == selectedFault,
                              ),
                            )
                            .toList(growable: false),
                        onSelectionChanged: (selectedItems) {
                          if (selectedItems.isEmpty) return;
                          final selection = selectedItems.first.value;
                          final nextFault = switch (selection) {
                            _MapGpuFaultSelection.none => null,
                            _MapGpuFaultSelection.atlasUpload =>
                              MapGpuFaultPoint.atlasUpload,
                            _MapGpuFaultSelection.shaderInterface =>
                              MapGpuFaultPoint.shaderInterface,
                            _MapGpuFaultSelection.frameSubmit =>
                              MapGpuFaultPoint.frameSubmit,
                          };
                          onFaultPointChanged(nextFault);
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: M3EOutlinedButton.icon(
                        key: eqmonitorMapGpuProbeInvalidateGenerationKey,
                        onPressed: onInvalidateRendererContextGeneration,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Renderer generation を無効化'),
                      ),
                    ),
                    const Divider(height: 24),
                    if (counters.isEmpty)
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Resource counter: 未取得'),
                      )
                    else
                      ...counters.map(
                        (entry) => _EqmonitorMapGpuResourceCounterRow(
                          label: entry.label,
                          counter: entry.counter,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EqmonitorMapGpuResourceCounterRow extends StatelessWidget {
  const new({required this.label, required this.counter});

  final String label;
  final MapGpuResourceKindCounter counter;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 72, child: Text(label)),
        Expanded(
          child: Text(
            'A ${counter.active} / C ${counter.candidate} / '
            'P ${counter.pendingRetire} / U ${counter.uploads} / '
            'R ${counter.retires}',
          ),
        ),
      ],
    ),
  );
}
