/// JMA Notification on Disaster Prevention definitions.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-6.
enum JmaNotificationOnDisasterPrevention {
  none(0, 'なし'),
  seaLevelChangeMay(101, '今後若干の海面変動があるかもしれません。'),
  seaLevelChangeNoDamage(102, '今後若干の海面変動があるかもしれませんが、被害の心配はありません。'),
  seaLevelChangeContinue(103, '今後もしばらく海面変動が続くと思われます。'),
  seaLevelChangeCautionSwimming(
    104,
    '今後もしばらく海面変動が続くと思われますので、海水浴や磯釣り等を行う際は注意してください。',
  ),
  seaLevelChangeCautionFishing(
    105,
    '今後もしばらく海面変動が続くと思われますので、磯釣り等を行う際は注意してください。',
  ),
  noTsunamiWarning(107, '現在、大津波警報・津波警報・津波注意報を発表している沿岸はありません。'),
  tsunamiHighTide(109, '津波と満潮が重なると、津波はより高くなりますので一層厳重な警戒が必要です。'),
  tsunamiHighTideCaution(110, '津波と満潮が重なると、津波はより高くなりますので十分な注意が必要です。'),
  tsunamiHigherPossible(111, '場所によっては、観測した津波の高さよりさらに大きな津波が到達しているおそれがあります。'),
  tsunamiMayGetHigher(112, '今後、津波の高さは更に高くなることも考えられます。'),
  tsunamiAlreadyArrived(113, '沖合での観測値をもとに津波が推定されている沿岸では、早いところでは、既に津波が到達していると推定されます。'),
  tsunamiMaxWaveDelay(114, '津波による潮位変化が観測されてから最大波が観測されるまでに数時間以上かかることがあります。'),
  tsunamiHigherAtCoast(115, '沖合での観測値であり、沿岸では津波はさらに高くなります。'),
  majorTsunamiWarning(
    121,
    '＜大津波警報＞\n大きな津波が襲い甚大な被害が発生します。\n沿岸部や川沿いにいる人はただちに高台や避難ビルなど安全な場所へ避難してください。\n津波は繰り返し襲ってきます。警報が解除されるまで安全な場所から離れないでください。',
  ),
  tsunamiWarning(
    122,
    '＜津波警報＞\n津波による被害が発生します。\n沿岸部や川沿いにいる人はただちに高台や避難ビルなど安全な場所へ避難してください。\n津波は繰り返し襲ってきます。警報が解除されるまで安全な場所から離れないでください。',
  ),
  tsunamiAdvisory(
    123,
    '＜津波注意報＞\n海の中や海岸付近は危険です。\n海の中にいる人はただちに海から上がって、海岸から離れてください。\n潮の流れが速い状態が続きますので、注意報が解除されるまで海に入ったり海岸に近づいたりしないようにしてください。',
  ),
  tsunamiForecast(124, '＜津波予報(若干の海面変動)＞\n若干の海面変動が予想されますが、被害の心配はありません。'),
  evacuateImmediately(
    131,
    '警報が発表された沿岸部や川沿いにいる人はただちに高台や避難ビルなど安全な場所へ避難してください。\n到達予想時刻は、予報区のなかで最も早く津波が到達する時刻です。場所によっては、この時刻よりもかなり遅れて津波が襲ってくることがあります。\n到達予想時刻から津波が最も高くなるまでに数時間以上かかることがありますので、観測された津波の高さにかかわらず、警報が解除されるまで安全な場所から離れないでください。',
  ),
  tsunamiHigherThanExpected(132, '場所によっては津波の高さが「予想される津波の高さ」より高くなる可能性があります。'),
  greatEastJapanClass(141, '東日本大震災クラスの津波が来襲します。'),
  upgradedToMajorTsunamiWarning(142, '沖合で高い津波を観測したため大津波警報・津波警報に切り替えました。'),
  switchedMajorTsunamiWarning(143, '沖合で高い津波を観測したため大津波警報・津波警報を切り替えました。'),
  upgradedToMajorTsunami(144, '沖合で高い津波を観測したため大津波警報に切り替えました。'),
  switchedToMajorTsunami(145, '沖合で高い津波を観測したため大津波警報を切り替えました。'),
  upgradedToTsunamiWarning(146, '沖合で高い津波を観測したため津波警報に切り替えました。'),
  switchedTsunamiWarning(147, '沖合で高い津波を観測したため津波警報を切り替えました。'),
  switchedExpectedHeight(148, '沖合で高い津波を観測したため予想される津波の高さを切り替えました。'),
  evacuateNow(149, 'ただちに避難してください。'),
  nankaiTroughInfo(150, '南海トラフ地震臨時情報を発表しています。'),
  strongShakingWarning(201, '強い揺れに警戒してください。'),
  tsunamiWarningIssued(211, '津波警報等(大津波警報・津波警報あるいは津波注意報)を発表中です。'),
  slightSeaLevelChange(212, 'この地震により、日本の沿岸では若干の海面変動があるかもしれませんが、被害の心配はありません。'),
  seaLevelChangeCautionSwimming2(
    213,
    '今後もしばらく海面変動が続くと思われますので、海水浴や磯釣り等を行う際は注意してください。',
  ),
  seaLevelChangeCautionFishing2(214, '今後もしばらく海面変動が続くと思われますので、磯釣り等を行う際は注意してください。'),
  noTsunamiConcern(215, 'この地震による津波の心配はありません。'),
  tsunamiPossibleSeafloor(216, '震源が海底の場合、津波が発生するおそれがあります。'),
  attentionFutureInfo(217, '今後の情報に注意してください。'),
  pacificWideTsunamiPossible(221, '太平洋の広域に津波発生の可能性があります。'),
  pacificTsunamiPossible(222, '太平洋で津波発生の可能性があります。'),
  northwestPacificTsunamiPossible(223, '北西太平洋で津波発生の可能性があります。'),
  indianOceanWideTsunamiPossible(224, 'インド洋の広域に津波発生の可能性があります。'),
  indianOceanTsunamiPossible(225, 'インド洋で津波発生の可能性があります。'),
  nearSourceTsunamiPossible(226, '震源の近傍で津波発生の可能性があります。'),
  nearSourceSmallTsunamiPossible(227, '震源の近傍で小さな津波発生の可能性がありますが、被害をもたらす津波の心配はありません。'),
  shallowSeaEarthquakeTsunami(228, '一般的に、この規模の地震が海域の浅い領域で発生すると、津波が発生することがあります。'),
  japanTsunamiInvestigating(229, '日本への津波の有無については現在調査中です。'),
  noTsunamiImpactJapan(230, 'この地震による日本への津波の影響はありません。'),
  eewIssued(241, 'この地震について、緊急地震速報を発表しています。'),
  eewIssuedMaxIntensity2(242, 'この地震について、緊急地震速報を発表しています。この地震の最大震度は2でした。'),
  eewIssuedMaxIntensity1(243, 'この地震について、緊急地震速報を発表しています。この地震の最大震度は1でした。'),
  eewIssuedNoIntensity(244, 'この地震について、緊急地震速報を発表しています。この地震で震度1以上は観測されていません。'),
  eewNoStrongShaking(245, 'この地震で緊急地震速報を発表しましたが、強い揺れは観測されませんでした。'),
  epicenterCorrection(256, '震源要素を訂正します。'),
  otherDisasterPrevention(500, 'その他の防災上の留意事項');

  const JmaNotificationOnDisasterPrevention(this.code, this.message);

  final int code;
  final String message;

  static JmaNotificationOnDisasterPrevention fromCode(int code) =>
      values.firstWhere((e) => e.code == code);
}

