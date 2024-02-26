import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerPage extends ConsumerWidget {
  const TalkerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => TalkerScreen(
        talker: ref.watch(talkerProvider),
      );
}
