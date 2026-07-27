import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_split_viewport_observer.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('計測がstaleな間はchild semanticsを公開しない', () {
    final observer =
        LiveMonitorSplitViewportRenderObject(
            active: true,
            environment: (
              screenSize: const Size(800, 400),
              viewPadding: EdgeInsets.zero,
              viewInsets: EdgeInsets.zero,
              orientation: Orientation.landscape,
            ),
            onMeasurementChanged: (_) {},
          )
          ..child = RenderConstrainedBox(
            additionalConstraints: const BoxConstraints.tightFor(
              width: 800,
              height: 400,
            ),
          );
    var visits = 0;

    observer.visitChildrenForSemantics((_) {
      visits += 1;
    });
    expect(visits, 0);

    observer.active = false;
    observer.visitChildrenForSemantics((_) {
      visits += 1;
    });
    expect(visits, 1);
  });
}
