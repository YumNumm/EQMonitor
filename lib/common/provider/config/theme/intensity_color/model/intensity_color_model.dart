// ignore_for_file: invalid_annotation_target

import 'package:eqapi_schema/eqapi_schema.dart';
import 'package:flutter/rendering.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_color_model.freezed.dart';
part 'intensity_color_model.g.dart';

@freezed
class IntensityColorModel with _$IntensityColorModel {
  const factory IntensityColorModel({
    /// 震度不明
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color intensityUnknownFront,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color intensityUnknownBack,

    /// 震度0
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color intensityZeroFront,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color intensityZeroBack,

    /// 震度1
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color intensityOneFront,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color intensityOneBack,

    /// 震度2
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color intensityTwoFront,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color intensityTwoBack,

    /// 震度3
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color intensityThreeFront,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color intensityThreeBack,

    /// 震度4
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color intensityFourFront,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color intensityFourBack,

    /// 震度5弱
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color intensityFiveLowerFront,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color intensityFiveLowerBack,

    /// 震度5強
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color intensityFiveUpperFront,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color intensityFiveUpperBack,

    /// 震度6弱
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color intensitySixLowerFront,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color intensitySixLowerBack,

    /// 震度6強
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color intensitySixUpperFront,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color intensitySixUpperBack,

    /// 震度7
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color intensitySevenFront,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color intensitySevenBack,
  }) = _IntensityColorModel;

  factory IntensityColorModel.fromJson(Map<String, dynamic> json) =>
      _$IntensityColorModelFromJson(json);
}

extension IntensityColorModelExt on IntensityColorModel {
  (Color front, Color background) fromJmaIntensity(JmaIntensity intensity) {
    switch (intensity) {
      case JmaIntensity.one:
        return (intensityOneFront, intensityOneBack);
      case JmaIntensity.two:
        return (intensityTwoFront, intensityTwoBack);
      case JmaIntensity.three:
        return (intensityThreeFront, intensityThreeBack);
      case JmaIntensity.four:
        return (intensityFourFront, intensityFourBack);
      case JmaIntensity.fiveUpperNoInput:
      case JmaIntensity.fiveLower:
        return (intensityFiveLowerFront, intensityFiveLowerBack);
      case JmaIntensity.fiveUpper:
        return (intensityFiveUpperFront, intensityFiveUpperBack);
      case JmaIntensity.sixLower:
        return (intensitySixLowerFront, intensitySixLowerBack);
      case JmaIntensity.sixUpper:
        return (intensitySixUpperFront, intensitySixUpperBack);
      case JmaIntensity.seven:
        return (intensitySevenFront, intensitySevenBack);
    }
  }

  (Color front, Color background) fromJmaForecastIntensity(
    JmaForecastIntensity intensity,
  ) {
    switch (intensity) {
      case JmaForecastIntensity.zero:
        return (intensityZeroFront, intensityZeroBack);
      case JmaForecastIntensity.one:
        return (intensityOneFront, intensityOneBack);
      case JmaForecastIntensity.two:
        return (intensityTwoFront, intensityTwoBack);
      case JmaForecastIntensity.three:
        return (intensityThreeFront, intensityThreeBack);
      case JmaForecastIntensity.four:
        return (intensityFourFront, intensityFourBack);
      case JmaForecastIntensity.fiveLower:
        return (intensityFiveLowerFront, intensityFiveLowerBack);
      case JmaForecastIntensity.fiveUpper:
        return (intensityFiveUpperFront, intensityFiveUpperBack);
      case JmaForecastIntensity.sixLower:
        return (intensitySixLowerFront, intensitySixLowerBack);
      case JmaForecastIntensity.sixUpper:
        return (intensitySixUpperFront, intensitySixUpperBack);
      case JmaForecastIntensity.seven:
        return (intensitySevenFront, intensitySevenBack);
      case JmaForecastIntensity.unknown:
        return (intensityUnknownFront, intensityUnknownBack);
    }
  }
}

Color colorFromJson(String color) => Color(int.parse(color, radix: 16));
String colorToJson(Color color) =>
    color.value.toRadixString(16).padLeft(8, '0');
