import 'history_content.dart';

class History {
  History({required this.contents});

  History.fromJson(Map<String, dynamic> j)
      : contents = (j['content'] == null)
            ? []
            : List.generate(
                (j['content'] as List<dynamic>).length,
                (index) => HistoryContent.fromJson(
                  (j['content'] as List<dynamic>)[index]
                      as Map<String, dynamic>,
                ),
              );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'content':
            List.generate(contents.length, (index) => contents[index].toJson()),
      };

  final List<HistoryContent> contents;
}
