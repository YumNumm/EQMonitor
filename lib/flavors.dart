enum Flavor {
  DEV,
  PROD,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.DEV:
        return 'EQMonitor Dev';
      case Flavor.PROD:
        return 'EQMonitor';
      default:
        return 'title';
    }
  }

}
