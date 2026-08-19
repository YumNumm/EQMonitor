import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LiveMonitorMeasuredCardOverlay extends HookWidget {
  const new({
    required this.onHeightChanged,
    required this.child,
    super.key,
  });

  final ValueChanged<double> onHeightChanged;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final measurementKey = useMemoized(GlobalKey.new);
    final previousHeight = useRef<double?>(null);
    final reportHeight = useCallback(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final height = measurementKey.currentContext?.size?.height;
        if (height == null || height == previousHeight.value) {
          return;
        }
        previousHeight.value = height;
        onHeightChanged(height);
      });
    }, [onHeightChanged]);
    useEffect(() {
      reportHeight();
      return null;
    }, [reportHeight]);

    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (_) {
        reportHeight();
        return false;
      },
      child: SizeChangedLayoutNotifier(key: measurementKey, child: child),
    );
  }
}
