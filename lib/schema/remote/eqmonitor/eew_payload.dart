import '../dmdata/eew-information/earthquake/accuracy.dart';
import '../dmdata/eew-information/intensity/intensity.dart';
import '../dmdata/eq-information/earthquake-information/hypocenter/depth/depth_condition.dart';
import '../dmdata/eq-information/earthquake-information/magnitude/magnitude_condition.dart';

class EewPayload {
  EewPayload({
    required this.depth,
    required this.depthCondition,
    required this.magnitude,
    required this.magnitudeCondition,
    required this.accuracy,
    required this.eventId,
    required this.intensity,
  });

  factory EewPayload.fromJson(Map<String, dynamic> json) {
    final hasDepthCondition = json['depth'] is String;
    final hasMagnitudeCondition = json['magnitude'] is String;

    return EewPayload(
      depth: hasDepthCondition ? null : int.tryParse(json['depth'].toString()),
      depthCondition: hasDepthCondition
          ? DepthCondition.values
              .firstWhere((e) => e.name == json['depth'].toString())
          : null,
      magnitude: hasMagnitudeCondition
          ? null
          : double.tryParse(json['magnitude'].toString()),
      magnitudeCondition: hasMagnitudeCondition
          ? MagnitudeCondition.values
              .firstWhere((e) => e.name == json['magnitude'].toString())
          : null,
      accuracy: (json['accuracy'] != null)
          ? Accuracy.fromJson(json['accuracy'] as Map<String, dynamic>)
          : null,
      eventId: int.parse(json['eventId'].toString()),
      intensity: (json['intensity'] != null)
          ? Intensity.fromJson(json['intensity'] as Map<String, dynamic>)
          : null,
    );
  }

  final int? depth;
  final DepthCondition? depthCondition;
  final double? magnitude;
  final MagnitudeCondition? magnitudeCondition;

  final Accuracy? accuracy;
  final int eventId;
  final Intensity? intensity;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'depth': (depthCondition != null) ? depthCondition!.name : depth,
        'magnitude':
            (magnitudeCondition != null) ? magnitudeCondition!.name : magnitude,
        'accuracy': accuracy?.toJson(),
        'eventId': eventId,
        'intensity': intensity?.toJson(),
      };
}
