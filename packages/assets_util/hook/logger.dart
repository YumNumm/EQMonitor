class Logger {
  static const name = 'assets_util';
  void info(String message) => _log('info', message);
  void warn(String message) => _log('warn', message);
  void error(String message) => _log('error', message);

  void _log(String level, String message) => print('[$name] $level: $message');
}
