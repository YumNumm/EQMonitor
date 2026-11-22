import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/feature/store_screenshot/data/notifier/store_screenshot_director.dart';
import 'package:eqmonitor/feature/store_screenshot/data/repository/store_screenshot_preferences_seeder.dart';
import 'package:eqmonitor/feature/store_screenshot/data/repository/store_screenshot_session_repository.dart';
import 'package:eqmonitor/main.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsApp.debugAllowBannerOverride = false;
  final repository = StoreScreenshotSessionRepository.inDocuments(
    await getApplicationDocumentsDirectory(),
  );
  try {
    final session = await repository.readSession();
    await const StoreScreenshotPreferencesSeeder().seed(
      dataSource: SharedPreferencesDataSource(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      values: session.preferences,
    );
    final container = await AppBootstrap.run();
    await StoreScreenshotDirector.runMutation.run(
      container,
      (transaction) => transaction
          .get(storeScreenshotDirectorProvider.notifier)
          .run(session: session),
    );
  } on Object catch (error, stackTrace) {
    await repository.markFailed(error: error, stackTrace: stackTrace);
    rethrow;
  }
}
