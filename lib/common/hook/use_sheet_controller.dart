import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sheet/sheet.dart';

SheetController useSheetController({
  String debugLabel = 'useSheetController',
}) =>
    use(_UseSheetControllerHook(debugLabel: debugLabel));

class _UseSheetControllerHook extends Hook<SheetController> {
  // ignore: unused_element
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
