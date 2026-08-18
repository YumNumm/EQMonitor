import 'package:freezed_annotation/freezed_annotation.dart';

part 'ntp_config_model.freezed.dart';
part 'ntp_config_model.g.dart';

@freezed
abstract class NtpConfigModel with _$NtpConfigModel {
  const factory({
    @Default('ntp.nict.jp') String lookUpAddress,

    /// [lookUpAddress] が使えなかった場合に順に試すサーバ。
    ///
    /// モバイル網では UDP:123 が閉じられていることがあるため、
    /// 経路の異なるサーバを複数用意しておく。
    @Default(['time.google.com', 'time.cloudflare.com'])
    List<String> fallbackAddresses,
    @Default(Duration(seconds: 3)) Duration timeout,
    @Default(Duration(minutes: 10)) Duration interval,

    /// 1つのサーバに対する試行回数
    @Default(2) int maxAttemptsPerAddress,
  }) = _NtpConfigModel;

  factory fromJson(Map<String, dynamic> json) => _$NtpConfigModelFromJson(json);
}

extension NtpConfigModelX on NtpConfigModel {
  /// 試行するサーバを優先順に並べたもの。重複は除去する。
  List<String> get addresses => <String>{
    lookUpAddress,
    ...fallbackAddresses,
  }.where((address) => address.isNotEmpty).toList();
}
