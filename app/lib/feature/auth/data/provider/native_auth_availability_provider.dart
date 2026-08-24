import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/feature/auth/data/provider/auth_environment_provider.dart';
import 'package:eqmonitor/feature/auth/data/repository/google_auth_repository.dart';
import 'package:eqmonitor/feature/auth/data/repository/native_social_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'native_auth_availability_provider.g.dart';

final class NativeAuthAvailability {
  const new({
    required this.environmentCompatible,
    required this.googleAvailable,
    required this.appleAvailable,
    required this.passkeyAvailable,
  });

  final bool environmentCompatible;
  final bool googleAvailable;
  final bool appleAvailable;
  final bool passkeyAvailable;
}

@riverpod
Future<NativeAuthAvailability> nativeAuthAvailability(Ref ref) async {
  final buildConfig = ref.watch(buildConfigProvider);
  final environment = await ref.watch(authEnvironmentProvider.future);
  final environmentCompatible = environment is Success;
  final platform = NativeAuthConfiguration.currentPlatform();
  final isNativePlatform = platform != NativeAuthPlatform.unsupported;
  final socialEnabled =
      environmentCompatible &&
      isNativePlatform &&
      buildConfig.isNativeSocialAuthEnabled;
  final googleClientId = switch (platform) {
    NativeAuthPlatform.ios => buildConfig.googleIosClientId,
    NativeAuthPlatform.android => buildConfig.googleAndroidClientId,
    NativeAuthPlatform.unsupported => '',
  };
  final googleAvailable =
      socialEnabled &&
      GoogleAuthConfiguration.isClientId(googleClientId) &&
      GoogleAuthConfiguration.isClientId(buildConfig.googleServerClientId) &&
      (platform != NativeAuthPlatform.ios ||
          NativeAuthConfiguration.isMatchingGoogleReversedClientId(
            clientId: googleClientId,
            reversedClientId: buildConfig.googleIosReversedClientId,
          ));
  final appleAvailable =
      socialEnabled &&
      (platform != NativeAuthPlatform.android ||
          NativeAuthConfiguration.isAppleServiceId(
            buildConfig.appleServiceId,
          ));
  return NativeAuthAvailability(
    environmentCompatible: environmentCompatible,
    googleAvailable: googleAvailable,
    appleAvailable: appleAvailable,
    passkeyAvailable: environmentCompatible && isNativePlatform,
  );
}
