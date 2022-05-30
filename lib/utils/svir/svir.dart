import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'svirResponse.dart';

class Svir extends GetxController {
  late Timer timer;
  final Rx<SvirResponse> svirResponse = SvirResponse.fromJson(
    jsonDecode(
      '{"Head":{"Title":"緊急地震速報（予報）","DateTime":"2022-05-19T08:54:00+09:00","EditorialOffice":"大阪管区気象台","PublishingOffice":"気象庁","EventID":"20220519085259","Status":"通常","Serial":"8","Version":"1.1"},"Body":{"Earthquake":{"OriginTime":"2022-05-19T08:52:40+09:00","Hypocenter":{"Name":"石垣島近海","Code":"854","Lat":"+23.1","Lon":"+123.7","Depth":"20","LandOrSea":"海域"},"Accuracy":{"Epicenter":["4","9"],"Depth":"4","MagnitudeCalculation":"5","NumberOfMagnitudeCalculation":"5"},"Magnitude":"5.2"},"Intensity":{"MaxInt":"2","TextInt":"震度２程度以上","ForecastInt":{"From":"2","To":"over"},"Appendix":{"MaxIntChange":"0","MaxIntChangeReason":"0"}},"PLUMFlag":"0","WarningFlag":"0","EndFlag":"1"}}',
    ) as Map<String, dynamic>,
  ).obs;
  static const String url = 'https://svir.jp/eew/data.json';
  void start() {
    // Timer Start
    timer = Timer.periodic(
      const Duration(milliseconds: 1000),
      (timer) async => await _updateData(),
    );
  }

  Future<void> _updateData() async {
    final res = await http.get(Uri.parse(url));
    final j = json.decode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
    final tmp = SvirResponse.fromJson(j);
    
    // 発表日時が
    // 1. 現在保持しているデータよりも新しい
    // 2. 発表されてから180秒以内 であることを確認する

    svirResponse.value = tmp;
  }
}
