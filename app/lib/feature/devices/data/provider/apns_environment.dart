import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'apns_environment.g.dart';

@Riverpod(keepAlive: true)
api.ApnsEnvironment apnsEnvironment(Ref ref) => api.ApnsEnvironment.production;
