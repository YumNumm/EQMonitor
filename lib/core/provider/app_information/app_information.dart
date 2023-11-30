import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/app_information/app_information_model.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:version/version.dart';

part 'app_information.g.dart';

@Riverpod(keepAlive: true)
class AppInformation extends _$AppInformation {
  @override
  AsyncValue<AppInformationModel>? build() {
    return null;
  }

  Future<Result<void, Exception>> load() async {
    if (state is AsyncLoading) {
      return const Result.success(null);
    }
    state = const AsyncLoading();
    final api = ref.read(eqApiProvider);
    try {
      final res = await api.v3.getAppInformation();
      state = AsyncData(
        res.toModel(
          currentVersion: Version.parse(ref.read(packageInfoProvider).version),
        ),
      );
      return const Success(null);
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
