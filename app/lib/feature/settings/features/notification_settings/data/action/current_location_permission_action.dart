import 'package:eqmonitor/feature/location/data/background_location_permission_provider.dart';
import 'package:eqmonitor/feature/permission/data/repository/permission_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';

class const CurrentLocationPermissionAction() {
  static final requestMutation = Mutation<bool>();

  Future<bool> request(WidgetRef ref) async {
    try {
      final granted = await requestMutation.run(ref, (tsx) async {
        final repository = tsx.get(permissionRepositoryProvider);
        final granted = await repository.requestBackgroundLocationPermission();
        if (!granted) {
          await repository.openLocationSettings();
        }
        return granted;
      });
      ref.invalidate(backgroundLocationPermissionProvider);
      return granted;
    } on Object {
      return false;
    }
  }
}
