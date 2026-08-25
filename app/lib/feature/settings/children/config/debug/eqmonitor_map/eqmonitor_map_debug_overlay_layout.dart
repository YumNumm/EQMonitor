import 'package:flutter/material.dart';

/// 地図の操作面とデバッグ用overlayのhit-test順を一箇所で定義する。
class EqmonitorMapDebugOverlayLayout extends StatelessWidget {
  const new({
    required this.map,
    required this.banner,
    required this.probePanel,
    super.key,
  });

  final Widget map;
  final Widget banner;
  final Widget? probePanel;

  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      map,
      Positioned.fill(
        child: SafeArea(
          minimum: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 2,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: banner,
                ),
              ),
              Expanded(
                flex: probePanel == null ? 3 : 1,
                child: const IgnorePointer(child: SizedBox.expand()),
              ),
              if (probePanel case final panel?)
                Flexible(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: panel,
                  ),
                ),
            ],
          ),
        ),
      ),
    ],
  );
}
