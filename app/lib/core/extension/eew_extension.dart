import 'package:eqmonitor_api/export.dart';

extension EewItemWithRelationsExtension on EewItemWithRelations {
  /// 警報かどうかを判定する
  ///
  /// `isWarning` が null の場合は `headline` に「強い揺れ」が含まれるかで判定
  bool get isWarningOrFallback =>
      isWarning ?? headline?.contains('強い揺れ') ?? false;
}
