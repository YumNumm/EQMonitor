import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tts_model.freezed.dart';

@freezed
class TtsModel with _$TtsModel {
  const factory TtsModel({
    /// TTS読み上げ中かどうか
    required bool isSpeaking,
  }) = _TtsModel;
}
