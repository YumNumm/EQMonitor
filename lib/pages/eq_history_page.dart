import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor/utils/dmdata/schemas/commonHeader.dart';
import 'package:eqmonitor/utils/eq_history/eq_history_lib.dart';
import 'package:eqmonitor/utils/map/customZoomPanBehavior.dart';
import 'package:eqmonitor/utils/updater/appUpdate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../utils/earthquake.dart';
import '../utils/messaging.dart';

class EqHistoryPage extends StatelessWidget {
  EqHistoryPage({Key? key}) : super(key: key);

  final Logger logger = Get.find<Logger>();
  final EarthQuake earthQuake = Get.find<EarthQuake>();
  final EqHistoryLib eqHistory = Get.find<EqHistoryLib>();
  final AppUpdate appUpdate = Get.find<AppUpdate>();
  final CustomZoomPanBehavior zoomPanBehavior =
      Get.find<CustomZoomPanBehavior>();
  final Messaging messaging = Get.find<Messaging>();
  final PackageInfo packageInfo = Get.find<PackageInfo>();
  final DateFormat df = DateFormat('yyyy/MM/dd HH:mm頃');

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Obx(
        () => ListView.builder(
          itemCount: eqHistory.content.length,
          itemBuilder: (BuildContext context, int i) {
            final eqLog = eqHistory.content[i];

            return Container(
              padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
              decoration: const BoxDecoration(),
              child: ListTile(
                onTap: () async {
                  final res = await http.get(Uri.parse(eqLog.url));
                  final payload = CommonHead.fromJson(
                    jsonDecode(
                      utf8.decode(gzip.decode(res.bodyBytes)).toString(),
                    ) as Map<String, dynamic>,
                  );
                  await Get.toNamed<void>(
                    '/eqinfo',
                    arguments: <String, dynamic>{
                      'payload': payload,
                      'eqLog': eqLog,
                    },
                  );
                },
                leading: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  child: Image.asset(
                    'assets/intensity/${(eqLog.maxint.contains("不明")) ? "unknown" : eqLog.maxint}.PNG',
                  ),
                ),
                title: Text(
                  df.format(eqLog.publishedDate.toLocal()),
                ),
                subtitle: Text('${eqLog.hypoName} M${eqLog.magnitude}'),
              ),
            );
          },
        ),
      ),
      onRefresh: () async => eqHistory.fetch(),
    );
  }
}
