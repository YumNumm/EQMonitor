import 'package:eqmonitor/core/component/layout/history_detail_scope.dart';
import 'package:eqmonitor/core/component/layout/history_pane.dart';
import 'package:eqmonitor/core/component/layout/history_pane_layout.dart';
import 'package:eqmonitor/core/component/layout/pane_viewport_measurement.dart';
import 'package:eqmonitor/core/component/layout/pane_viewport_observer.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

/// 一覧と詳細の要素を維持し、表示領域だけを切り替える。
class HistoryAdaptiveView extends HookWidget {
  const new({
    required this.list,
    required this.detail,
    required this.onCloseDetail,
    super.key,
  });

  final Widget list;
  final Widget? detail;
  final VoidCallback onCloseDetail;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final measurement = useState<PaneViewportMeasurement?>(null);
    final avoidBounds = DisplayFeatureSubScreen.avoidBounds(media).toList();
    final hasDetail = detail != null;

    return PopScope(
      canPop: !hasDetail,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && hasDetail) onCloseDetail();
      },
      child: PaneViewportObserver(
        active: avoidBounds.isNotEmpty,
        environment: (
          screenSize: media.size,
          viewPadding: media.viewPadding,
          viewInsets: media.viewInsets,
          orientation: media.orientation,
        ),
        onMeasurementChanged: (value) => measurement.value = value,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = constraints.biggest;
            final measured = measurement.value;
            final isMeasured =
                measured != null &&
                measured.viewportSize == size &&
                measured.screenSize == media.size &&
                measured.viewPadding == media.viewPadding &&
                measured.viewInsets == media.viewInsets &&
                measured.orientation == media.orientation;
            final layout = HistoryPaneLayout.calculate(
              size: size,
              avoidBounds: avoidBounds,
              globalOrigin: isMeasured ? measured.globalOrigin : null,
            );
            final available = layout.available;
            final listBounds = layout.list;
            final detailBounds = layout.detail;
            final isSplit = listBounds != null;
            final waiting = avoidBounds.isNotEmpty && !isMeasured;
            return IgnorePointer(
              ignoring: waiting,
              child: Opacity(
                opacity: waiting ? 0 : 1,
                child: ColoredBox(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  child: Stack(
                    children: [
                      Positioned.fromRect(
                        rect: listBounds ?? available,
                        child: Offstage(
                          offstage: !isSplit && hasDetail,
                          child: TickerMode(
                            enabled: isSplit || !hasDetail,
                            child: HistoryPane(
                              bounds: listBounds ?? available,
                              viewport: size,
                              child: list,
                            ),
                          ),
                        ),
                      ),
                      Positioned.fromRect(
                        rect: detailBounds ?? available,
                        child: Offstage(
                          offstage: !isSplit && !hasDetail,
                          child: HistoryPane(
                            bounds: detailBounds ?? available,
                            viewport: size,
                            child: HistoryDetailScope(
                              isSplit: isSplit,
                              child: detail ?? const _UnselectedDetail(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _UnselectedDetail extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) => Material(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          '一覧から表示する情報を選択してください',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    ),
  );
}
