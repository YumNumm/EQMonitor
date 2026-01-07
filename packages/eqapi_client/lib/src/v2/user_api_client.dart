import 'package:dio/dio.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:retrofit/retrofit.dart';

part 'user_api_client.g.dart';

/// ユーザーAPI
@RestApi()
abstract class UserApiClient {
  factory UserApiClient(Dio dio, {String baseUrl}) = _UserApiClient;

  /// ユーザーを作成
  @POST('/v2/user')
  Future<User> createUser();

  /// ユーザー情報を取得
  @GET('/v2/user/{userId}')
  Future<User> getUser({
    @Path('userId') required String userId,
  });
}
