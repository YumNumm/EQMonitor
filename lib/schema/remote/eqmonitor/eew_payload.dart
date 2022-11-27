import 'package:dmdata_telegram_json/dmdata_telegram_json.dart';

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
          ? EewDepthCondition.values
              .firstWhere((e) => e.name == json['depth'].toString())
          : null,
      magnitude: hasMagnitudeCondition
          ? null
          : double.tryParse(json['magnitude'].toString()),
      magnitudeCondition: hasMagnitudeCondition
          ? EarthquakeComponentMagnitudeCondition.values
              .firstWhere((e) => e.name == json['magnitude'].toString())
          : null,
      accuracy: (json['accuracy'] != null)
          ? EewAccuracy.fromJson(json['accuracy'] as Map<String, dynamic>)
          : null,
      eventId: int.parse(json['eventId'].toString()),
      intensity: (json['intensity'] != null)
          ? EewIntensity.fromJson(json['intensity'] as Map<String, dynamic>)
          : null,
    );
  }

  final int? depth;
  final EewDepthCondition? depthCondition;
  final double? magnitude;
  final EarthquakeComponentMagnitudeCondition? magnitudeCondition;

  final EewAccuracy? accuracy;
  final int eventId;
  final EewIntensity? intensity;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'depth': (depthCondition != null) ? depthCondition!.name : depth,
        'magnitude':
            (magnitudeCondition != null) ? magnitudeCondition!.name : magnitude,
        'accuracy': accuracy?.toJson(),
        'eventId': eventId,
        'intensity': intensity?.toJson(),
      };
}
