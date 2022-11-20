import 'package:eqmonitor/provider/init/talker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

class LogView extends ConsumerWidget {
  const LogView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final talker = ref.watch(talkerProvider);
    return TalkerScreen(
      talker: talker,
      appBarTitle: 'アプリ内ログ',
    );
  }
}
