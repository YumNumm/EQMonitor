import 'package:freezed_annotation/freezed_annotation.dart';

part 'apns_token_kind.g.dart';

@JsonEnum(alwaysCreate: true, valueField: 'json')
enum ApnsTokenKind(final String json) {
  notification('NOTIFICATION'),
  liveActivityStart('LIVE_ACTIVITY_START'),
}
