import 'package:eqmonitor/feature/start/data/model/required_version_model.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:version/version.dart';

class ForcedUpdateRequirementMatcher {
  const ForcedUpdateRequirementMatcher({required this.packageInfo});

  final PackageInfo packageInfo;

  bool isUpdateRequired(RequiredVersionModel requiredVersion) {
    final versionUpdateRequired = isVersionUpdateRequired(requiredVersion);
    final buildUpdateRequired = isBuildNumberUpdateRequired(requiredVersion);
    return versionUpdateRequired || buildUpdateRequired;
  }

  bool isVersionUpdateRequired(RequiredVersionModel requiredVersion) {
    final requiredVersionString = requiredVersion.version;
    if (requiredVersionString == null) {
      return false;
    }

    Version current;
    Version required;
    try {
      current = Version.parse(packageInfo.version);
      required = Version.parse(requiredVersionString);
    } on FormatException {
      return false;
    }
    return current < required;
  }

  bool isBuildNumberUpdateRequired(RequiredVersionModel requiredVersion) {
    final requiredBuildNumber = requiredVersion.buildNumber;
    if (requiredBuildNumber == null) {
      return false;
    }

    final currentBuildNumber = int.tryParse(packageInfo.buildNumber);
    if (currentBuildNumber == null) {
      return false;
    }
    return currentBuildNumber < requiredBuildNumber;
  }
}
