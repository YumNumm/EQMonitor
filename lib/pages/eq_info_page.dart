import 'package:eqmonitor/utils/dmdata/schemas/commonHeader.dart';
import 'package:eqmonitor/utils/dmdata/schemas/eq-information/earthquake-information.dart';
import 'package:eqmonitor/utils/eq_history/eq_history_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EqInfoPage extends StatelessWidget {
  EqInfoPage({Key? key}) : super(key: key);

  final payload =
      (Get.arguments as Map<String, dynamic>)['payload'] as CommonHead;
  final data = EarthquakeInformation.fromJson(
    ((Get.arguments as Map<String, dynamic>)['payload'] as CommonHead).body,
  );
  final eqLog =
      (Get.arguments as Map<String, dynamic>)['eqLog'] as EqHistoryContent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('震源・震度情報'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Image.network(
                  eqLog.imageUrl,
                  cacheWidth: 1024,
                  cacheHeight: 512,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
