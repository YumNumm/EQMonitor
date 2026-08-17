import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const notificationChannelGroups = <AndroidNotificationChannelGroup>[
  AndroidNotificationChannelGroup('eew', '緊急地震速報'),
  AndroidNotificationChannelGroup('earthquake', '地震情報'),
  AndroidNotificationChannelGroup('tsunami', '津波情報'),
  AndroidNotificationChannelGroup('safety_information', '防災・関連情報'),
  AndroidNotificationChannelGroup('service', 'サービス通知'),
];

const notificationChannels = <AndroidNotificationChannel>[
  AndroidNotificationChannel(
    'eew_warning_current_location',
    '現在地が対象の緊急地震速報（警報）',
    groupId: 'eew',
    importance: Importance.high,
  ),
  AndroidNotificationChannel(
    'eew_warning_nationwide',
    '全国設定だけで受ける緊急地震速報（警報）',
    groupId: 'eew',
  ),
  AndroidNotificationChannel(
    'eew_forecast',
    '緊急地震速報（予報）',
    groupId: 'eew',
    importance: Importance.high,
  ),
  AndroidNotificationChannel(
    'eew_low_accuracy_v2',
    '1点検知・レベル法の低精度EEW',
    groupId: 'eew',
  ),
  AndroidNotificationChannel(
    'earthquake_vxse51',
    '震度速報',
    groupId: 'earthquake',
    importance: Importance.high,
  ),
  AndroidNotificationChannel(
    'earthquake_vxse52',
    '震源情報',
    groupId: 'earthquake',
  ),
  AndroidNotificationChannel(
    'earthquake_vxse53',
    '震源・震度情報',
    groupId: 'earthquake',
    importance: Importance.high,
  ),
  AndroidNotificationChannel(
    'earthquake_vxse61',
    '震源要素更新',
    groupId: 'earthquake',
  ),
  AndroidNotificationChannel(
    'earthquake_vxse62',
    '長周期地震動情報',
    groupId: 'earthquake',
    importance: Importance.high,
  ),
  AndroidNotificationChannel(
    'earthquake_estimated_intensity',
    '推計震度情報',
    groupId: 'earthquake',
    importance: Importance.low,
    playSound: false,
  ),
  AndroidNotificationChannel(
    'tsunami_major_warning',
    '大津波警報',
    groupId: 'tsunami',
    importance: Importance.high,
  ),
  AndroidNotificationChannel(
    'tsunami_warning',
    '津波警報・第1波到達',
    groupId: 'tsunami',
    importance: Importance.high,
  ),
  AndroidNotificationChannel(
    'tsunami_advisory',
    '津波注意報',
    groupId: 'tsunami',
    importance: Importance.high,
  ),
  AndroidNotificationChannel(
    'tsunami_update',
    '更新・切替・解除・取消',
    groupId: 'tsunami',
  ),
  AndroidNotificationChannel(
    'tsunami_passive',
    '津波予報・沖合観測',
    groupId: 'tsunami',
    importance: Importance.low,
    playSound: false,
  ),
  AndroidNotificationChannel(
    'earthquake_notice',
    'VZSE40',
    groupId: 'safety_information',
    importance: Importance.low,
    playSound: false,
  ),
  AndroidNotificationChannel(
    'nankai_information',
    '南海トラフ臨時・解説情報',
    groupId: 'safety_information',
    importance: Importance.high,
  ),
  AndroidNotificationChannel(
    'aftershock_advisory',
    '北海道・三陸沖後発地震注意情報',
    groupId: 'safety_information',
    importance: Importance.high,
  ),
  AndroidNotificationChannel(
    'shake_detection',
    '揺れ検知',
    groupId: 'safety_information',
    importance: Importance.high,
  ),
  AndroidNotificationChannel(
    'training_information',
    '訓練・試験情報',
    groupId: 'safety_information',
    importance: Importance.low,
    playSound: false,
  ),
  AndroidNotificationChannel('service_test', '通常テスト通知', groupId: 'service'),
  AndroidNotificationChannel(
    'service_test_critical',
    '重大テスト通知',
    groupId: 'service',
    importance: Importance.high,
  ),
  AndroidNotificationChannel(
    'service_fallback',
    'Channel 未指定通知の fallback',
    groupId: 'service',
  ),
  AndroidNotificationChannel(
    'bgl_debug',
    'アプリ内バックグラウンド位置デバッグ',
    groupId: 'service',
    importance: Importance.low,
    playSound: false,
  ),
];

const legacyNotificationChannelIds = <String>[
  'fromdev',
  'bgl_debug',
  'eew_warning',
  'eew_forecast',
  'eew_low_accuracy',
  'VXSE51',
  'VXSE52',
  'VXSE53',
  'VXSE61',
  'VXSE62',
  'VZSE40',
  'VYSE50',
  'VYSE51',
  'VYSE52',
  'test',
  'test_critical',
];
