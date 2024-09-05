import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: 'type')
enum TelegramType {
  vxse45('緊急地震速報（地震動予報）'),
  vtse41('津波警報・注意報・予報a'),
  vtse51('津波情報a'),
  vtse52('沖合の津波観測に関する情報'),
  vtse52Cancel('各地の満潮時刻・津波到達予想時刻に関する情報'),
  vtse52Cancel2('津波観測に関する情報'),
  vxse51('震度速報'),
  vxse52('震源に関する情報'),
  vxse53('震源・震度に関する情報'),
  vxse53distant('遠地地震に関する情報'),
  vxse56('地震の活動状況等に関する情報'),
  vxse60('地震回数に関する情報'),
  vxse61('顕著な地震の震源要素更新のお知らせ'),
  vxse62('長周期地震動に関する観測情報'),
  vyse50('南海トラフ地震臨時情報'),
  vyse51('南海トラフ地震関連解説情報'),
  vyse52('南海トラフ地震関連解説情報');

  const TelegramType(this.type);
  final String type;
}

@JsonEnum(valueField: 'type')
enum SchemaType {
  eewInformation('eew-information'),
  earthquakeInformation('earthquake-information'),
  earthquakeExplanation('earthquake-explanation'),
  earthquakeCounts('earthquake-counts'),
  earthquakeHypocenterUpdate('earthquake-hypocenter-update'),
  earthquakeNankai('earthquake-nankai'),
  tsunamiInformation('tsunami-information');

  const SchemaType(this.type);
  final String type;
}
