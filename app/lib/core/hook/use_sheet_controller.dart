import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sheet/sheet.dart';

// flutter_hooks の Hook はトップレベル関数として定義する規約であり、
// クラスのメソッドにすると Hook の登録順序が壊れて動作しない。
// ignore: eqmonitor_lints_plugin/avoid_top_level_functions
SheetController useSheetController({
  String debugLabel = 'useSheetController',
}) => use(_UseSheetControllerHook(debugLabel: debugLabel));

class _UseSheetControllerHook extends Hook<SheetController> {
  const _UseSheetControllerHook({this.debugLabel = 'useSheetController'});

  final String debugLabel;

  @override
  HookState<SheetController, Hook<SheetController>> createState() =>
      _UseSheetControllerHookState();
}

class _UseSheetControllerHookState
    extends HookState<SheetController, _UseSheetControllerHook> {
  late final _sheetController = SheetController(debugLabel: hook.debugLabel);

  @override
  SheetController build(BuildContext context) => SheetController();

  @override
  void dispose() => _sheetController.dispose();

  @override
  String get debugLabel => 'useSheetController';
}
