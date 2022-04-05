import './P2PJMAQuake.dart';

class P2PJMAQuakes {
  final List<P2PJMAQuake>? list;
  P2PJMAQuakes({required this.list});
  P2PJMAQuakes.fromList(List<dynamic>? l)
      : list = (l.toString() == '')
            ? null
            : List.generate(
                l!.length,
                (index) =>
                    P2PJMAQuake.fromJson(l[index] as Map<String, dynamic>),
              );
}
