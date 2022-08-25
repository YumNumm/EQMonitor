class ChangeLog {
  ChangeLog({
    required this.items,
  });

  factory ChangeLog.fromJson(Map<String, dynamic> json) => ChangeLog(
        items: List<ChangeLogItem>.from(
          (json['items'] as List<Map<String, dynamic>>)
              .map(ChangeLogItem.fromJson),
        ),
      );

  final List<ChangeLogItem> items;
}

class ChangeLogItem {
  ChangeLogItem({
    required this.isBreakingChange,
    required this.version,
    required this.date,
    required this.comment,
    required this.url,
    required this.buildId,
  });
  
  factory ChangeLogItem.fromJson(Map<String, dynamic> json) => ChangeLogItem(
        isBreakingChange: json['isBreakingChange'],
        version: json['version'],
        date: DateTime.parse(json['date']),
        comment: json['comment'],
        url: json['url'],
        buildId: int.parse(json['buildId'].toString()),
      );

  final String comment;
  final DateTime date;
  final bool isBreakingChange;
  final String url;
  final String version;
  final int buildId;

  Map<String, dynamic> tojson() => <String, dynamic>{
        'isBreakingChange': isBreakingChange,
        'version': version,
        'date': date.toIso8601String(),
        'comment': comment,
        'url': url,
        'build_id': buildId,
      };
}
