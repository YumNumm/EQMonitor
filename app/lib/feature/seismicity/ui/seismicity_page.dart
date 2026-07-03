import 'package:flutter/material.dart';

/// 地震活動画面(震央分布 + 矩形選択によるM-T図・積算・深さ断面)。
class SeismicityPage extends StatelessWidget {
  const SeismicityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('地震活動')),
      body: const Placeholder(),
    );
  }
}
