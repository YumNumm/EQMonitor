import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:eqapi_cli/src/api_client.dart';
import 'package:eqapi_cli/src/commands/earthquake_command.dart';
import 'package:eqapi_cli/src/commands/eew_command.dart';

Future<void> main(List<String> arguments) async {
  final runner = CommandRunner<void>('eqapi', 'CLI tool for EQMonitor API v2')
    ..addCommand(EarthquakeCommand())
    ..addCommand(EewCommand());

  try {
    await runner.run(arguments);
  } on UsageException catch (e) {
    print(e);
    exit(64);
  } finally {
    ApiClient.dispose();
  }
}
