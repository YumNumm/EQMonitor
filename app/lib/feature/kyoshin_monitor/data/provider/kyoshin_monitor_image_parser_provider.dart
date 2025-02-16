import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kyoshin_monitor_image_parser/kyoshin_monitor_image_parser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_image_parser_provider.g.dart';

@Riverpod(keepAlive: true)
KyoshinMonitorImageParser kyoshinMonitorImageParser(
  Ref ref,
) => KyoshinMonitorImageParser();
