import 'dart:developer';

import 'package:eqmonitor/main.dart';
import 'package:logger/logger.dart';

class MyFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}

class MyOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (final line in event.lines) {
      logToFile(line);
      log(line);
    }
  }
}
