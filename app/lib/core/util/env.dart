// ignore_for_file: do_not_use_environment

// ignore: avoid_classes_with_only_static_members
class Env {
  static Flavor flavor = Flavor.values.byName(
    const String.fromEnvironment('FLAVOR'),
  );
  static const restApiUrl = String.fromEnvironment('REST_API_URL');
  static const wsApiUrl = String.fromEnvironment('WS_API_URL');
  static const apiAuthorization = String.fromEnvironment(
    'API_AUTHORIZATION',
  );
}

enum Flavor { dev, prod }
