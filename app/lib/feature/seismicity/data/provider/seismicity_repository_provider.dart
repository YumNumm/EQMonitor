import 'package:eqmonitor/core/provider/dio_provider.dart';
import 'package:eqmonitor/feature/seismicity/data/repository/seismicity_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'seismicity_repository_provider.g.dart';

@Riverpod(keepAlive: true)
Future<SeismicityRepository> seismicityRepository(Ref ref) async {
  final dio = await ref.watch(dioProvider.future);
  return SeismicityRepository(dio: dio);
}
