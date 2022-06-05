import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../schemas/dmdata/eq-information/earthquake-information.dart';


class PrefWidget extends StatelessWidget {
  const PrefWidget({super.key, required this.pref, required this.data});
  final String pref;
  final EarthquakeInformation data;
  @override
  Widget build(BuildContext context) {
    // 市区町村リスト
    return Column(
      children: [
        Text(
          pref,
          style: context.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
