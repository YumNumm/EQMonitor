import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';

abstract class KyoshinMonitorWebApiResponse {
  new({required this.security, required this.result});

  final Security? security;
  final Result? result;
}
