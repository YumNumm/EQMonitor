import 'package:flutter/widgets.dart';

typedef PaneViewportEnvironment = ({
  Size screenSize,
  EdgeInsets viewPadding,
  EdgeInsets viewInsets,
  Orientation orientation,
});

typedef PaneViewportMeasurement = ({
  Offset globalOrigin,
  Size viewportSize,
  Size screenSize,
  EdgeInsets viewPadding,
  EdgeInsets viewInsets,
  Orientation orientation,
});
