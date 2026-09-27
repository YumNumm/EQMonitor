import 'dart:io';

import 'package:eqmonitor/core/fcm/channels.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('defines the exact notification channel groups', () {
    const expected = {
      'eew': '緊急地震速報',
      'earthquake': '地震情報',
      'tsunami': '津波情報',
      'safety_information': '防災・関連情報',
      'service': 'サービス通知',
    };

    expect(notificationChannelGroups, hasLength(5));
    expect({
      for (final group in notificationChannelGroups) group.id: group.name,
    }, expected);
  });

  test('defines the exact notification channel registry', () {
    const expected = [
      (
        id: 'eew_warning_current_location',
        groupId: 'eew',
        name: '現在地が対象の緊急地震速報（警報）',
        importance: Importance.high,
      ),
      (
        id: 'eew_warning_nationwide',
        groupId: 'eew',
        name: '全国設定だけで受ける緊急地震速報（警報）',
        importance: Importance.defaultImportance,
      ),
      (
        id: 'eew_forecast',
        groupId: 'eew',
        name: '緊急地震速報（予報）',
        importance: Importance.high,
      ),
      (
        id: 'eew_low_accuracy_v2',
        groupId: 'eew',
        name: '1点検知・レベル法の低精度EEW',
        importance: Importance.defaultImportance,
      ),
      (
        id: 'earthquake_vxse51',
        groupId: 'earthquake',
        name: '震度速報',
        importance: Importance.high,
      ),
      (
        id: 'earthquake_vxse52',
        groupId: 'earthquake',
        name: '震源情報',
        importance: Importance.defaultImportance,
      ),
      (
        id: 'earthquake_vxse53',
        groupId: 'earthquake',
        name: '震源・震度情報',
        importance: Importance.high,
      ),
      (
        id: 'earthquake_vxse61',
        groupId: 'earthquake',
        name: '震源要素更新',
        importance: Importance.defaultImportance,
      ),
      (
        id: 'earthquake_vxse62',
        groupId: 'earthquake',
        name: '長周期地震動情報',
        importance: Importance.high,
      ),
      (
        id: 'earthquake_estimated_intensity',
        groupId: 'earthquake',
        name: '推計震度情報',
        importance: Importance.low,
      ),
      (
        id: 'tsunami_major_warning',
        groupId: 'tsunami',
        name: '大津波警報',
        importance: Importance.high,
      ),
      (
        id: 'tsunami_warning',
        groupId: 'tsunami',
        name: '津波警報・第1波到達',
        importance: Importance.high,
      ),
      (
        id: 'tsunami_advisory',
        groupId: 'tsunami',
        name: '津波注意報',
        importance: Importance.high,
      ),
      (
        id: 'tsunami_update',
        groupId: 'tsunami',
        name: '更新・切替・解除・取消',
        importance: Importance.defaultImportance,
      ),
      (
        id: 'tsunami_passive',
        groupId: 'tsunami',
        name: '津波予報・沖合観測',
        importance: Importance.low,
      ),
      (
        id: 'earthquake_notice',
        groupId: 'safety_information',
        name: 'VZSE40',
        importance: Importance.low,
      ),
      (
        id: 'nankai_information',
        groupId: 'safety_information',
        name: '南海トラフ臨時・解説情報',
        importance: Importance.high,
      ),
      (
        id: 'aftershock_advisory',
        groupId: 'safety_information',
        name: '北海道・三陸沖後発地震注意情報',
        importance: Importance.high,
      ),
      (
        id: 'shake_detection',
        groupId: 'safety_information',
        name: '揺れ検知',
        importance: Importance.high,
      ),
      (
        id: 'training_information',
        groupId: 'safety_information',
        name: '訓練・試験情報',
        importance: Importance.low,
      ),
      (
        id: 'service_test',
        groupId: 'service',
        name: '通常テスト通知',
        importance: Importance.defaultImportance,
      ),
      (
        id: 'service_test_critical',
        groupId: 'service',
        name: '重大テスト通知',
        importance: Importance.high,
      ),
      (
        id: 'service_fallback',
        groupId: 'service',
        name: 'Channel 未指定通知の fallback',
        importance: Importance.defaultImportance,
      ),
      (
        id: 'bgl_debug',
        groupId: 'service',
        name: 'アプリ内バックグラウンド位置デバッグ',
        importance: Importance.low,
      ),
    ];

    expect(notificationChannels, hasLength(24));
    expect(
      notificationChannels.map(
        (channel) => (
          id: channel.id,
          groupId: channel.groupId,
          name: channel.name,
          importance: channel.importance,
        ),
      ),
      expected,
    );
  });

  test('channel ids are unique and every group exists', () {
    final ids = notificationChannels.map((channel) => channel.id).toList();
    expect(ids.toSet(), hasLength(ids.length));
    final groups = notificationChannelGroups.map((group) => group.id).toSet();
    for (final channel in notificationChannels) {
      expect(groups, contains(channel.groupId));
    }
  });

  test('uses standard sound without DND bypass and keeps low silent', () {
    for (final channel in notificationChannels) {
      expect(channel.bypassDnd, isFalse, reason: channel.id);
      expect(channel.sound, isNull, reason: channel.id);
      expect(
        channel.playSound,
        channel.importance != Importance.low,
        reason: channel.id,
      );
    }
  });

  test('defines the exact legacy channel ids', () {
    expect(legacyNotificationChannelIds, const [
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
    ]);
  });

  test('manifest uses the service fallback channel', () {
    final manifest = File(
      'android/app/src/main/AndroidManifest.xml',
    ).readAsStringSync();
    expect(
      manifest,
      matches(
        RegExp(
          r'<meta-data\s+'
          r'android:name="com\.google\.firebase\.messaging\.default_notification_channel_id"\s+'
          r'android:value="service_fallback"\s*/>',
          multiLine: true,
        ),
      ),
    );
  });
}
