import 'package:eqmonitor/feature/seismicity/ui/seismicity_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // NOTE: This test intentionally avoids importing
  // `package:eqmonitor/core/router/router.dart`. That file transitively
  // pulls in `lib/core/provider/chuck_provider.dart`, which imports the
  // undeclared `package:chuck_interceptor` dependency and fails to compile.
  // That breakage is pre-existing and unrelated to the seismicity route
  // wiring added in this change (see report for details); route
  // registration itself was verified via `dart run build_runner build`
  // (which generated `$SeismicityRoute`) and `dart analyze`.
  testWidgets('SeismicityPage renders a Scaffold with the expected title', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SeismicityPage()));

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.text('地震活動'), findsOneWidget);
  });
}
