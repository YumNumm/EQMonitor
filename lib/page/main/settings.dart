import 'package:collection/collection.dart';
import 'package:eqmonitor/const/kmoni/jma_intensity.dart';
import 'package:eqmonitor/state/all_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fcm = ref.watch(firebaseCloudMessagingNotifier);
    final map = ref
        .watch(kmoniMapController)
        .mapPolygons
        .groupListsBy((element) => element.code);
    map.forEach((key, value) {
      print(key);
    });
    return ListView.builder(
      itemCount: map.length,
      itemBuilder: (context, index) {
        final key = map.keys.elementAt(index);
        final value = map.values.elementAt(index);
        return ListTile(
          title: Text(value.first.name),
          subtitle: Text(key.toString()),
          trailing: Text("震度${JmaIntensity.Int0.name}以上"),
        );
      },
    );
  }
}
