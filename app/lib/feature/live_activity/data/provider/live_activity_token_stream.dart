import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/feature/live_activity/data/provider/eqm_live_activity_util.dart';
import 'package:live_activity_util/live_activity_util.dart';
import 'package:objective_c/objective_c.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_activity_token_stream.g.dart';

typedef LiveActivityTokenUpdate = ({
  String liveActivityId,
  String token,
  String activityType,
});

@Riverpod(keepAlive: true)
Stream<LiveActivityTokenUpdate> liveActivityPushTokenUpdates(Ref ref) {
  assert(
    !Platform.isAndroid,
    'Live Activity is only supported on iOS',
  );

  final util = ref.watch(eqmLiveActivityUtilProvider);
  final controller = StreamController<LiveActivityTokenUpdate>.broadcast();
  ref.onDispose(controller.close);

  util.observeEewActivityPushTokenUpdates(
    ObjCBlock_ffiVoid_NSString_NSString.listener(
      (nsId, nsToken) {
        controller.add((
          liveActivityId: nsId.toDartString(),
          token: nsToken.toDartString(),
          activityType: 'eew',
        ));
      },
    ),
  );

  util.observeShakeDetectionActivityPushTokenUpdates(
    ObjCBlock_ffiVoid_NSString_NSString.listener(
      (nsId, nsToken) {
        controller.add((
          liveActivityId: nsId.toDartString(),
          token: nsToken.toDartString(),
          activityType: 'shakeDetection',
        ));
      },
    ),
  );

  return controller.stream;
}
