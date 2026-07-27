import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_split_ratio.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class LiveMonitorSplitViewportObserver extends SingleChildRenderObjectWidget {
  const LiveMonitorSplitViewportObserver({
    required this.active,
    required this.environment,
    required this.onMeasurementChanged,
    required super.child,
    super.key,
  });

  final bool active;
  final LiveMonitorSplitViewportEnvironment environment;
  final ValueChanged<LiveMonitorSplitViewportMeasurement> onMeasurementChanged;

  @override
  LiveMonitorSplitViewportRenderObject createRenderObject(
    BuildContext context,
  ) => LiveMonitorSplitViewportRenderObject(
    active: active,
    environment: environment,
    onMeasurementChanged: onMeasurementChanged,
  );

  @override
  void updateRenderObject(
    BuildContext context,
    LiveMonitorSplitViewportRenderObject renderObject,
  ) {
    renderObject
      ..active = active
      ..environment = environment
      ..onMeasurementChanged = onMeasurementChanged;
  }
}

class LiveMonitorSplitViewportRenderObject extends RenderProxyBox {
  LiveMonitorSplitViewportRenderObject({
    required bool active,
    required LiveMonitorSplitViewportEnvironment environment,
    required ValueChanged<LiveMonitorSplitViewportMeasurement>
    onMeasurementChanged,
  }) : _active = active,
       _environment = environment,
       _measurementIsCurrent = !active,
       _onMeasurementChanged = onMeasurementChanged;

  bool _active;
  LiveMonitorSplitViewportEnvironment _environment;
  ValueChanged<LiveMonitorSplitViewportMeasurement> _onMeasurementChanged;
  LiveMonitorSplitViewportMeasurement? _reportedMeasurement;
  LiveMonitorSplitViewportMeasurement? _pendingMeasurement;
  bool _measurementIsCurrent;
  bool _reportScheduled = false;

  set active(bool value) {
    if (_active == value) {
      return;
    }
    _active = value;
    _reportedMeasurement = null;
    _pendingMeasurement = null;
    final nextMeasurementIsCurrent = !value;
    if (_measurementIsCurrent != nextMeasurementIsCurrent) {
      _measurementIsCurrent = nextMeasurementIsCurrent;
      markNeedsSemanticsUpdate();
    }
    markNeedsPaint();
  }

  set environment(LiveMonitorSplitViewportEnvironment value) {
    if (_environment == value) {
      return;
    }
    _environment = value;
    if (_measurementIsCurrent) {
      _measurementIsCurrent = false;
      markNeedsSemanticsUpdate();
    }
    markNeedsPaint();
  }

  set onMeasurementChanged(
    ValueChanged<LiveMonitorSplitViewportMeasurement> value,
  ) {
    _onMeasurementChanged = value;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (!_active) {
      super.paint(context, offset);
      return;
    }
    final measurement = (
      globalOrigin: localToGlobal(Offset.zero),
      viewportSize: size,
      screenSize: _environment.screenSize,
      viewPadding: _environment.viewPadding,
      viewInsets: _environment.viewInsets,
      orientation: _environment.orientation,
    );
    final shouldReport = shouldReportLiveMonitorSplitViewportMeasurement(
      previous: _reportedMeasurement,
      current: measurement,
    );
    final nextMeasurementIsCurrent = !shouldReport;
    if (_measurementIsCurrent != nextMeasurementIsCurrent) {
      _measurementIsCurrent = nextMeasurementIsCurrent;
      markNeedsSemanticsUpdate();
    }
    if (!shouldReport) {
      super.paint(context, offset);
      return;
    }
    _pendingMeasurement = measurement;
    if (_reportScheduled) {
      return;
    }
    _reportScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _reportScheduled = false;
      if (!attached || !_active) {
        return;
      }
      final pendingMeasurement = _pendingMeasurement;
      if (pendingMeasurement == null) {
        return;
      }
      _pendingMeasurement = null;
      _reportedMeasurement = pendingMeasurement;
      markNeedsPaint();
      _onMeasurementChanged(pendingMeasurement);
    });
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (_active && !_measurementIsCurrent) {
      return false;
    }
    return super.hitTest(result, position: position);
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    if (_active && !_measurementIsCurrent) {
      return;
    }
    super.visitChildrenForSemantics(visitor);
  }

  @override
  void detach() {
    _reportedMeasurement = null;
    _pendingMeasurement = null;
    if (_active && _measurementIsCurrent) {
      _measurementIsCurrent = false;
      markNeedsSemanticsUpdate();
    }
    super.detach();
  }
}
