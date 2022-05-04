import 'package:eqmonitor/utils/EQMonitorApi/history_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class NotificationHistoryPage extends StatelessWidget {
  NotificationHistoryPage({Key? key}) : super(key: key);
  final Logger logger = Get.find<Logger>();
  final history = Get.find<HistoryLib>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future<void>.delayed(const Duration(milliseconds: 1000));
        await history.fetch();
      },
      child: Obx(
        () => ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: history.content.length,
          itemBuilder: (BuildContext context, int i) {
            final h = history.content[i];
            return ListTile(
              title: Text(h.title),
              subtitle: Text(h.publishedDate.toIso8601String()),
            );
          },
        ),
      ),
    );
  }
}
