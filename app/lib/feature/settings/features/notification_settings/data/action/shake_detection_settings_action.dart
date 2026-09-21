import 'package:eqmonitor/feature/location/data/background_location_permission_provider.dart';
import 'package:eqmonitor/feature/permission/data/repository/permission_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/shake_detection_settings_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';

class const ShakeDetectionSettingsAction() {
  Future<void> save(WidgetRef ref, List<ShakeDetectionEntry> entries) async {
    try {
      await ShakeDetectionSettingsNotifier.saveMutation.run(ref, (tsx) async {
        await tsx.get(shakeDetectionSettingsProvider.notifier).save(entries);
      });
    } on Object {
      // The mutation listener displays the error; saved state is retained.
    }
  }

  static final locationPermissionMutation = Mutation<void>();

  Future<void> requestLocationPermission(WidgetRef ref) async {
    try {
      await locationPermissionMutation.run(ref, (tsx) async {
        await tsx
            .get(permissionRepositoryProvider)
            .requestBackgroundLocationPermission();
      });
      ref.invalidate(backgroundLocationPermissionProvider);
    } on Object {
      // Keep the permission guidance visible when permission cannot be requested.
    }
  }
}
