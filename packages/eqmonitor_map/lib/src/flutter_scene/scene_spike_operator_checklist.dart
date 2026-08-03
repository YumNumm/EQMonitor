import 'package:eqmonitor_map/src/observability/scene_spike_observation.dart';

class SceneSpikeOperatorCriterion {
  const SceneSpikeOperatorCriterion({required this.id, required this.label});

  final String id;
  final String label;
}

class SceneSpikeOperatorChecklistContract {
  const SceneSpikeOperatorChecklistContract._();

  static const Map<SceneSpikeCapability, List<SceneSpikeOperatorCriterion>>
  criteria = {
    .proceduralOrthographicMesh: [
      SceneSpikeOperatorCriterion(
        id: 'quad_visible',
        label: 'Procedural quad is visible.',
      ),
      SceneSpikeOperatorCriterion(
        id: 'north_up',
        label: 'Geometry remains north-up without bearing or pitch.',
      ),
    ],
    .unlitMaterial: [
      SceneSpikeOperatorCriterion(
        id: 'vertex_colors_visible',
        label: 'Vertex colors are visible on the unlit quad.',
      ),
      SceneSpikeOperatorCriterion(
        id: 'lighting_independent',
        label: 'Lighting does not alter the displayed colors.',
      ),
    ],
    .customMaterial: [
      SceneSpikeOperatorCriterion(
        id: 'custom_quad_visible',
        label: 'The custom-material quad is visible.',
      ),
      SceneSpikeOperatorCriterion(
        id: 'no_fallback',
        label: 'No fallback material is displayed.',
      ),
    ],
    .textPainterOverlay: [
      SceneSpikeOperatorCriterion(
        id: 'label_above_scene',
        label: 'The label is composited above SceneView.',
      ),
      SceneSpikeOperatorCriterion(
        id: 'label_anchor_aligned',
        label: 'The label remains aligned to its geographic anchor.',
      ),
    ],
    .dprAndResize: [
      SceneSpikeOperatorCriterion(
        id: 'resize_preserves_scene',
        label: 'Resize preserves the scene contents.',
      ),
      SceneSpikeOperatorCriterion(
        id: 'dpr_preserves_alignment',
        label: 'DPR changes preserve label alignment.',
      ),
    ],
  };

  static List<SceneSpikeOperatorCriterion> criteriaFor(
    SceneSpikeCapability capability,
  ) => criteria[capability] ?? const [];
}
