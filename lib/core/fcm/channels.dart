// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final List<AndroidNotificationChannel> notificationChannels = [
  const AndroidNotificationChannel(
    'fromdev',
    '開発者からのお知らせ',
    description: '開発者からの連絡に使用されます。',
    groupId: 'fromdev',
    importance: Importance.high,
  ),
  //! EEW
  const AndroidNotificationChannel(
    'eew_alert',
    '緊急地震速報(警報)',
    groupId: 'eew',
    description: '緊急地震速報(警報)通知',
    ledColor: Color.fromARGB(255, 190, 0, 0),
    importance: Importance.max,
  ),
  const AndroidNotificationChannel(
    'eew',
    '緊急地震速報(予報)',
    groupId: 'eew',
    description: '緊急地震速報(予報)通知',
    ledColor: Color.fromARGB(255, 190, 0, 0),
    importance: Importance.high,
  ),
  //! 地震通知
  const AndroidNotificationChannel(
    'VZSE40',
    groupId: 'earthquake',
    '地震・津波に関するお知らせ',
    description: '地震・津波の試験・訓練配信のお知らせ、自治体震度データの入電停止等のお知らせ、その他を発表',
    importance: Importance.low,
  ),
  const AndroidNotificationChannel(
    'VTSE41',
    groupId: 'tsunami',
    '津波警報・注意報・予報',
    description:
        '影響をもたらす津波が到達すると予測された地域、または影響がなくなった地域に対して、津波警報・注意報・予報の発表・切替及び解除について、予報区ごとに予想の高さや津波到達時間、震源要素等を発表',
    importance: Importance.max,
  ),
  const AndroidNotificationChannel(
    'VTSE51',
    groupId: 'tsunami',
    '津波情報',
    description: '各地の満潮時刻、津波到達予想時刻に関する情報及び地上観測点における津波観測に関する情報を発表',
    importance: Importance.high,
  ),
  const AndroidNotificationChannel(
    'VTSE52',
    groupId: 'tsunami',
    '沖合の津波情報',
    description: '沖合の観測点における津波観測に関する情報を発表',
    importance: Importance.high,
  ),
  const AndroidNotificationChannel(
    'WEPA60',
    groupId: 'tsunami',
    '国際津波関連情報(国内向け)',
    description:
        '北西太平洋域でM6.5以上の地震が発生した場合、北西太平洋域の各国が津波警報等の発表に資するための支援情報として発表するものを複製した国内向け配信',
    importance: Importance.high,
  ),
  const AndroidNotificationChannel(
    'VXSE51',
    groupId: 'earthquake',
    '震度速報',
    description: '震度3以上の地域を90秒程度で第1報を通知',
    importance: Importance.high,
  ),
  const AndroidNotificationChannel(
    'VXSE52',
    groupId: 'earthquake',
    '震源に関する情報',
    description: '震源速報、津波の有無を通知',
    importance: Importance.high,
  ),
  const AndroidNotificationChannel(
    'VXSE53',
    groupId: 'earthquake',
    '震源・震度に関する情報',
    description: '震源要素・各地の震度、海外で発生した大きな地震の震源要素等、津波の有無を通知',
    importance: Importance.high,
  ),
  const AndroidNotificationChannel(
    'VXSE56',
    groupId: 'earthquake',
    '地震の活動状況等に関する情報',
    description: '地震の活動状況等に関する情報や、伊豆東部の地震活動に関する情報などの解説情報を発表',
    importance: Importance.high,
  ),
  const AndroidNotificationChannel(
    'VXSE60',
    groupId: 'earthquake',
    '地震回数に関する情報',
    description: '顕著な地震に対して、有感地震の回数経過状況を発表',
    importance: Importance.high,
  ),
  const AndroidNotificationChannel(
    'VXSE61',
    groupId: 'earthquake',
    '顕著な地震の震源要素更新のお知らせ',
    description: '顕著な地震に対して、震源要素をより正確にした情報を発表',
  ),
  const AndroidNotificationChannel(
    'VXSE62',
    groupId: 'earthquake',
    '長周期地震動に関する観測情報',
    description: '長周期地震動階級1以上を観測した地震について、観測した要素などを地震発生後10分程度で発表',
    importance: Importance.high,
  ),
  const AndroidNotificationChannel(
    'VYSE50',
    groupId: 'earthquake',
    '南海トラフ地震臨時情報',
    description: '南海トラフ沿いで異常な現象が観測され、その現象が南海トラフ沿いの大規模な地震発生が警戒される場合に発表',
    importance: Importance.high,
  ),
  const AndroidNotificationChannel(
    'VYSE51',
    groupId: 'earthquake',
    '南海トラフ地震関連解説情報(定例外)',
    description:
        '南海トラフ沿いで異常な現象が観測され、その現象が南海トラフ沿いの大規模な地震と関連するかどうか調査を開始・解説・終了した場合等に発表',
    importance: Importance.high,
  ),
  const AndroidNotificationChannel(
    'VYSE52',
    groupId: 'earthquake',
    '南海トラフ地震関連解説情報(定例)',
    description: '南海トラフ沿いの地震に関する評価検討会の定例会合における調査結果の発表',
    importance: Importance.high,
  ),
];

final List<AndroidNotificationChannelGroup> notificationChannelGroups = [
  const AndroidNotificationChannelGroup(
    'eew',
    '緊急地震速報',
  ),
  const AndroidNotificationChannelGroup(
    'earthquake',
    '地震通知',
  ),
  const AndroidNotificationChannelGroup(
    'tsunami',
    '津波通知',
  ),
  const AndroidNotificationChannelGroup(
    'fromdev',
    '開発者からのお知らせ',
  ),
];
