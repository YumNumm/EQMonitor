import 'package:eqmonitor/feature/nied/data/provider/nied_dio_provider.dart';
import 'package:nied_api_client/nied_api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nied_api_client_provider.g.dart';

@Riverpod(keepAlive: true)
NiedApiClient niedApiClient(Ref ref) => NiedApiClient(
  dio: ref.watch(niedDioProvider),
);
