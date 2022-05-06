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
            final Widget leading = Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/notification_type/${h.type.name}.PNG',
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                (h.pictureUrl != null)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          h.pictureUrl.toString().replaceAll(
                                'https://raw.githubusercontent.com/EQMonitor/EQMonitor/main/docs/intensity/',
                                'assets/intensity/',
                              ),
                        ),
                      )
                    : Container(),
              ],
            );
            final Widget subtitle = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(df.format(h.publishedDate.toLocal())),
                //if (h.bigPictureUrl != null)
                //  Image.network(h.bigPictureUrl.toString())
              ],
            );
            if (h.type == NotificationType.vxse53) {
              return ExpansionTile(
                title: Text(h.title),
                leading: leading,
                subtitle: subtitle,
                children: [
                  Image.network(
                    h.bigPictureUrl.toString(),
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: child,
                          ),
                        );
                      }
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Text(
                                '${(loadingProgress.cumulativeBytesLoaded / 1024).ceilToDouble()}KB'
                                '${(loadingProgress.expectedTotalBytes != null) ? '/${(loadingProgress.expectedTotalBytes! / 1024).ceilToDouble()}KB' : ''}',
                              ),
                              CircularProgressIndicator.adaptive(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              );
            } else {
              return ListTile(
                leading: leading,
                title: Text(h.title),
                subtitle: subtitle,
              );
            }
          },
        ),
      ),
    );
  }
}
