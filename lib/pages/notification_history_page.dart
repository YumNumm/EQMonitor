import 'package:eqmonitor/utils/EQMonitorApi/history_content.dart';
import 'package:eqmonitor/utils/EQMonitorApi/history_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class NotificationHistoryPage extends StatelessWidget {
  NotificationHistoryPage({Key? key}) : super(key: key);
  final Logger logger = Get.find<Logger>();
  final history = Get.find<HistoryLib>();
  final DateFormat df = DateFormat('yyyy/MM/dd HH:mm頃');

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
              leading: (h.pictureUrl != null)
                  ? Image.asset(
                      h.pictureUrl.toString().replaceAll(
                            'https://raw.githubusercontent.com/EQMonitor/EQMonitor/main/docs/intensity/',
                            'assets/intensity/',
                          ),
                    )
                  : null,
              title: Text(h.title),
              subtitle: Text(df.format(h.publishedDate.toLocal())),
            );
          },
        ),
      ),
    );
  }
}
