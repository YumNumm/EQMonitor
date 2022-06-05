import './Body.dart';
import 'Head.dart';

class SvirResponse {
  SvirResponse({
    required this.body,
    required this.head,
  });
  SvirResponse.fromJson(Map<String, dynamic> j)
      : head = SvirHead.fromJson(j['Head'] as Map<String, dynamic>),
        body = SvirBody.fromJson(j['Body'] as Map<String, dynamic>);
  final SvirHead head;
  final SvirBody body;
}
