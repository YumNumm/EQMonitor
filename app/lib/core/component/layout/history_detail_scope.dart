import 'package:flutter/widgets.dart';

/// 実際のペイン配置に基づく詳細画面のナビゲーション設定。
class const HistoryDetailScope({
  required final bool isSplit,
  required super.child,
  super.key,
}) extends InheritedWidget {
  static bool showBackButtonOf(BuildContext context) =>
      !(context
              .dependOnInheritedWidgetOfExactType<HistoryDetailScope>()
              ?.isSplit ??
          false);

  static bool isSplitOf(BuildContext context) =>
      context.getInheritedWidgetOfExactType<HistoryDetailScope>()?.isSplit ??
      false;

  @override
  bool updateShouldNotify(HistoryDetailScope oldWidget) =>
      isSplit != oldWidget.isSplit;
}
