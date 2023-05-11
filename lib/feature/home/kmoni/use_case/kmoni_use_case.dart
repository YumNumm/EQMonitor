import 'package:eqmonitor/feature/home/kmoni/data/kmoni_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kmoni_use_case.g.dart';

@Riverpod(dependencies: [kmoniDataSource])
KmoniUseCase kmoniUseCase(KmoniUseCaseRef ref) => KmoniUseCase(
      ref.watch(kmoniDataSourceProvider),
    );

class KmoniUseCase {
  KmoniUseCase(this.dataSource);

  final KmoniDataSource dataSource;
}
