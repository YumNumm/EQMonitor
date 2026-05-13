import 'package:eqmonitor/feature/knet_waveform/ui/media/knet_fig_view.dart';
import 'package:eqmonitor/feature/knet_waveform/ui/media/knet_movie_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// K-NET all/fig PNG・all/movie MP4 を表示するページ
class KnetMediaPage extends StatelessWidget {
  const KnetMediaPage({required this.eventTime, super.key});

  /// 地震発生時刻（JST）
  final DateTime eventTime;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '強震記録 ${formatter.format(eventTime)}',
            overflow: TextOverflow.ellipsis,
          ),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.image), text: 'PNG図'),
              Tab(icon: Icon(Icons.movie), text: 'MP4動画'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            KnetFigView(eventTime: eventTime),
            KnetMovieView(eventTime: eventTime),
          ],
        ),
      ),
    );
  }
}
