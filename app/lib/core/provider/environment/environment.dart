import 'package:eqmonitor/core/model/environment.dart' as model;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'environment.g.dart';

@Riverpod(keepAlive: true)
model.BuildConfig buildConfig(Ref ref) => model.BuildConfig.fromEnvironment();
