import 'package:freezed_annotation/freezed_annotation.dart';

part 'apns_token_kind.g.dart';

@JsonEnum(alwaysCreate: true, valueField: 'json')
enum ApnsTokenKind {
  notification('notification'),
  liveActivityStart('liveActivityStart');

  const ApnsTokenKind(this.json);

  final String json;
}
