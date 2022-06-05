import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eqmonitor/utils/EQMonitorApi/history_lib.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../schemas/eqmonitor_api/history_content.dart';

class NotificationHistoryPage extends StatelessWidget {
  NotificationHistoryPage({super.key});
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
                          h.pictureUrl
                              .toString()
                              .replaceAll(
                                'https://raw.githubusercontent.com/EQMonitor/EQMonitor/main/docs/intensity/',
                                'assets/intensity/',
                              )
                              .replaceAll('不明', 'unknown'),
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
                //  CachedNetworkImage(imageUrl:h.bigPictureUrl.toString())
              ],
            );
            if (h.type == NotificationType.vxse53) {
              return ExpansionTile(
                title: Text(h.title),
                leading: leading,
                subtitle: subtitle,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: CachedNetworkImage(
                        imageUrl: h.bigPictureUrl.toString(),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                          value: downloadProgress.progress,
                        ),
                        errorWidget: (context, url, dynamic error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  if (kDebugMode)
                    AutoSizeText(
                      'id: ${h.id}',
                      maxLines: 1,
                      style: const TextStyle(color: Colors.grey),
                    ),
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
