import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'jma_intensity_color_model.freezed.dart';

@freezed
class JmaIntensityColorModel with _$JmaIntensityColorModel {
  const factory JmaIntensityColorModel({
    required Color unknown,
    required Color int0,
    required Color int1,
    required Color int2,
    required Color int3,
    required Color int4,
    required Color int5Lower,
    required Color int5Upper,
    required Color int6Lower,
    required Color int6Upper,
    required Color int7,
    required Color over,
    required Color error,
  }) = _JmaIntensityColorModel;
}
