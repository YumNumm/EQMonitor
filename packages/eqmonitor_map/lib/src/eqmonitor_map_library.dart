const eqmonitorMapLibrary = EqmonitorMapLibrary(
  packageName: 'eqmonitor_map',
  supportedPlatforms: ['ios', 'android'],
);

class EqmonitorMapLibrary {
  const EqmonitorMapLibrary({
    required this.packageName,
    required this.supportedPlatforms,
  });

  final String packageName;
  final List<String> supportedPlatforms;
}
