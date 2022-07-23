import 'package:eqmonitor/state/all_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fcm = ref.watch(firebaseCloudMessagingNotifier);
    return Center(
      child: Text(fcm.token.toString()),
    );
  }
}
