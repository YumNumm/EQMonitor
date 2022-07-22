/// GET https://api.dmdata.jp/v2/telegram
class TelegramList {
  TelegramList({
    required this.url,
    required this.nextToken,
    required this.nextPooling,
    required this.nextPoolingInterval,
  });

  factory TelegramList.fromJson(Map<String, dynamic> j) {
    final items = j['items'] as List<dynamic>;
    final urls = List<String>.generate(
      items.length,
      (index) => (items[index] as Map<String, dynamic>)['url'].toString(),
    );
    return TelegramList(
      url: urls,
      nextToken: j['nextToken'].toString(),
      nextPooling: j['nextPooling'].toString(),
      nextPoolingInterval: int.parse(j['nextPoolingInterval'].toString()),
    );
  }

  final List<String> url;
  final String nextToken;
  final String nextPooling;
  final int nextPoolingInterval;
}
