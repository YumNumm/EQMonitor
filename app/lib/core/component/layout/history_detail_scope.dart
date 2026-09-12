import 'package:flutter/widgets.dart';

/// 実際のペイン配置に基づく詳細画面のナビゲーション設定。
class HistoryDetailScope extends InheritedWidget {
  const new({required this.isSplit, required super.child, super.key});

  final bool isSplit;

  static bool showBackButtonOf(BuildContext context) =>
      !(context
              .dependOnInheritedWidgetOfExactType<HistoryDetailScope>()
              ?.isSplit ??
          false);

  @override
  bool updateShouldNotify(HistoryDetailScope oldWidget) =>
      isSplit != oldWidget.isSplit;
}
