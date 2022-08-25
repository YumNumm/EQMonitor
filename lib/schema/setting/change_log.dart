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
    required this.newFeature,
    required this.fix,
    required this.isBreakingChange,
    required this.version,
    required this.date,
    required this.comment,
    required this.url,
  });
  factory ChangeLogItem.fromJson(Map<String, dynamic> json) => ChangeLogItem(
        newFeature: List<String>.from(json['newFeature']),
        fix: List<String>.from(json['fix']),
        isBreakingChange: json['isBreakingChange'],
        version: json['version'],
        date: DateTime.parse(json['date']),
        comment: json['comment'],
        url: json['url'],
      );

  final String comment;
  final DateTime date;
  final List<String> fix;
  final bool isBreakingChange;
  final List<String> newFeature;
  final String url;
  final String version;

  Map<String, dynamic> tojson() => <String, dynamic>{
        'newFeature': newFeature,
        'fix': fix,
        'isBreakingChange': isBreakingChange,
        'version': version,
        'date': date.toIso8601String(),
        'comment': comment,
        'url': url,
      };
}


