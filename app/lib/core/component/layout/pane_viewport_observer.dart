import 'package:eqmonitor/core/component/layout/pane_viewport_measurement.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class PaneViewportObserver extends SingleChildRenderObjectWidget {
  const new({
    required this.active,
    required this.environment,
    required this.onMeasurementChanged,
    required super.child,
    super.key,
  });

  final bool active;
  final PaneViewportEnvironment environment;
  final ValueChanged<PaneViewportMeasurement> onMeasurementChanged;

  @override
  PaneViewportRenderObject createRenderObject(
    BuildContext context,
  ) => PaneViewportRenderObject(
    active: active,
    environment: environment,
    onMeasurementChanged: onMeasurementChanged,
  );

  @override
  void updateRenderObject(
    BuildContext context,
    PaneViewportRenderObject renderObject,
  ) {
    renderObject
      ..active = active
      ..environment = environment
      ..onMeasurementChanged = onMeasurementChanged;
  }
}

class PaneViewportRenderObject extends RenderProxyBox {
  new({
    required bool active,
    required PaneViewportEnvironment environment,
    required ValueChanged<PaneViewportMeasurement> onMeasurementChanged,
  }) : _active = active,
       _environment = environment,
       _measurementIsCurrent = !active,
       _onMeasurementChanged = onMeasurementChanged;

  bool _active;
  PaneViewportEnvironment _environment;
  ValueChanged<PaneViewportMeasurement> _onMeasurementChanged;
  PaneViewportMeasurement? _reportedMeasurement;
  PaneViewportMeasurement? _pendingMeasurement;
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

  set environment(PaneViewportEnvironment value) {
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
    ValueChanged<PaneViewportMeasurement> value,
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
    final shouldReport = _reportedMeasurement != measurement;
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
