import 'package:freezed_annotation/freezed_annotation.dart';

part 'debugger_model.freezed.dart';
part 'debugger_model.g.dart';

@freezed
class DebuggerModel with _$DebuggerModel {
  const factory DebuggerModel({
    @Default(false) bool isDebugger,
    @Default(false) bool isDeveloper,
  }) = _DebuggerModel;

  factory DebuggerModel.fromJson(Map<String, dynamic> json) =>
      _$DebuggerModelFromJson(json);
}
