const eqmonitorMapLibrary = EqmonitorMapLibrary(
  packageName: 'eqmonitor_map',
  supportedPlatforms: ['ios', 'android'],
);

class EqmonitorMapLibrary {
  const new({
    required this.packageName,
    required this.supportedPlatforms,
  });

  final String packageName;
  final List<String> supportedPlatforms;
}
