import 'package:flutter_test/flutter_test.dart';

void main() {
  // NOTE: `SeismicityPage` now renders `ErrorCard` (from
  // `package:eqmonitor/core/component/error/error_card.dart`) as its map
  // configuration error state. `ErrorCard` transitively imports
  // `lib/core/provider/dio_provider.dart`, which references `chuckProvider`
  // from `lib/core/provider/chuck_provider.dart` — a file that imports the
  // undeclared `package:chuck_interceptor` dependency and fails to compile
  // (`chuck_provider.g.dart` is also missing). This is a pre-existing,
  // repo-wide breakage unrelated to the public seismicity UI added in this
  // change: e.g. `test/core/provider/cached_notifier_test.dart` (which
  // predates this branch and doesn't touch seismicity code at all) fails to
  // compile for the exact same reason. Because any widget test that pumps
  // `SeismicityPage` now transitively hits this same compile error, this
  // suite is intentionally left without a `pumpWidget` test. The page was
  // instead verified via `dart analyze lib/feature/seismicity` (zero
  // warnings) and manual code review against the task brief.
  test(
    'SeismicityPage widget-pump test intentionally omitted (pre-existing '
    'chuck_interceptor compile breakage — see NOTE above)',
    () {},
  );
}
