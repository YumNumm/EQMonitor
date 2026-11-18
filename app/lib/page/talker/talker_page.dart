import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

class const TalkerPage({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      TalkerScreen(talker: talker);
}
