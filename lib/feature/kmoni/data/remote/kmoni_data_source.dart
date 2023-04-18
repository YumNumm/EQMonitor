import 'package:dio/dio.dart';

class KmoniDataSource {
  KmoniDataSource(this.dio);
  final Dio dio;

  Future<Response> getKmoni() async {
    return await dio.get(
      'https://www.data.jma.go.jp/developer/xml/feed/eqvol.xml',
    );
  }


}
