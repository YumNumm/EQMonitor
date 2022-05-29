import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor/utils/map/customZoomPanBehavior.dart';
import 'package:eqmonitor/utils/updater/appUpdate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../utils/dmdata/schemas/commonHeader.dart';
import '../utils/earthquake-history/earthquake-history.dart';
import '../utils/earthquake.dart';
import '../utils/messaging.dart';

class EqHistoryPage extends StatelessWidget {
  EqHistoryPage({super.key});

  final Logger logger = Get.find<Logger>();
  final EarthQuake earthQuake = Get.find<EarthQuake>();
  final EarthQuakeHistory eqHistory = Get.find<EarthQuakeHistory>();
  final AppUpdate appUpdate = Get.find<AppUpdate>();
  final CustomZoomPanBehavior zoomPanBehavior =
      Get.find<CustomZoomPanBehavior>();
  final Messaging messaging = Get.find<Messaging>();
  final PackageInfo packageInfo = Get.find<PackageInfo>();
  final DateFormat df = DateFormat('yyyy/MM/dd HH:mm頃');
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          child: Obx(
            () => ListView.builder(
              controller: _scrollController,
              itemCount: eqHistory.vxse53Telegrams.length,
              itemBuilder: (BuildContext context, int i) {
                final eqLog = eqHistory.vxse53Telegrams[i];
                final previousData =
                    (i - 1 > 0) ? eqHistory.vxse53Telegrams[i - 1] : null;
                final shouldShowDivider =
                    (previousData?.time.toLocal().day ?? -1) !=
                            eqLog.time.toLocal().day &&
                        previousData != null;

                if (eqHistory.vxse53Telegrams.length - 1 == i &&
                    eqHistory.maxItemCount != i) {
                  eqHistory.getMoreData();
                  return const Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  );
                }
                return Container(
                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                  decoration: const BoxDecoration(),
                  child: Column(
                    children: [
                      if (shouldShowDivider) const Divider(),
                      ListTile(
                        onTap: () async {
                          var response = <int>[];
                          await Get.showOverlay(
                            asyncFunction: () async {
                              final res = await http.get(Uri.parse(eqLog.url));
                              response = res.bodyBytes;
                            },
                            loadingWidget: const Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          );
                          final payload = CommonHead.fromJson(
                            jsonDecode(
                              utf8.decode(gzip.decode(response)).toString(),
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          child: Image.asset(
                            'assets/intensity/${eqLog.maxint ?? "unknown"}.PNG',
                          ),
                        ),
                        title: Text(
                          df.format(eqLog.time.toLocal()),
                        ),
                        subtitle: Text(
                          '${eqLog.hypoName ?? '震源地不明'} M${(eqLog.magnitude ?? eqLog.magnitudeCondition ?? "不明").toString().replaceAll("M", "")}',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          onRefresh: () async => eqHistory.onInit(),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
              },
              child: const Icon(Icons.arrow_upward),
            ),
          ),
        )
      ],
    );
  }
}
