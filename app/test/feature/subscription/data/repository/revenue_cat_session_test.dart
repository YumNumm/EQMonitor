import 'dart:async';

import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:talker_flutter/talker_flutter.dart';
import 'package:eqmonitor/feature/subscription/data/exception/revenue_cat_unavailable_exception.dart';
import 'package:eqmonitor/feature/subscription/data/repository/revenue_cat_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/subscription_fixtures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('purchases_flutter');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  var configured = false;
  var identity = 'anonymous';
  var token = 'token';
  var failLogin = false;
  var failConfigure = false;
  final calls = <String>[];
  late RevenueCatSession session;

  setUpAll(() => talker_lib.talker = Talker());
  setUp(() {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    configured = false;
    identity = 'anonymous';
    token = 'token';
    failLogin = false;
    failConfigure = false;
    calls.clear();
    session = RevenueCatSession(
      deviceId: 'device',
      token: token,
      apiKey: 'test',
      readToken: () async => token,
    );
    messenger.setMockMethodCallHandler(channel, (call) async {
      calls.add(call.method);
      switch (call.method) {
        case 'isConfigured':
          return configured;
        case 'setupPurchases':
          if (failConfigure) throw PlatformException(code: '10');
          configured = true;
          return null;
        case 'getAppUserID':
          return identity;
        case 'logIn':
          if (failLogin) throw PlatformException(code: '10');
          identity = 'device';
          return {'customerInfo': emptyCustomerInfo, 'created': false};
        default:
          return null;
      }
    });
  });
  tearDown(() {
    messenger.setMockMethodCallHandler(channel, null);
    debugDefaultTargetPlatformOverride = null;
  });

  test(
    'serializes configure, identity and simultaneous purchase/restore',
    () async {
      final entered = Completer<void>();
      final release = Completer<void>();
      final operations = <String>[];
      final first = session.run(
        operation: () async {
          operations.add('purchase');
          entered.complete();
          await release.future;
          return identity;
        },
      );
      await entered.future;
      final second = session.run(
        operation: () async {
          operations.add('restore');
          return identity;
        },
      );
      await Future<void>.delayed(Duration.zero);
      expect(operations, ['purchase']);
      release.complete();
      expect(await first, 'device');
      expect(await second, 'device');
      expect(calls.where((name) => name == 'setupPurchases').length, 1);
      expect(calls.where((name) => name == 'logIn').length, 1);
    },
  );

  test(
    'configure failure stops login and operation then allows retry',
    () async {
      failConfigure = true;
      var operated = false;
      await expectLater(
        session.run(
          operation: () async {
            operated = true;
          },
        ),
        throwsA(isA<PlatformException>()),
      );
      expect(operated, isFalse);
      expect(calls, isNot(contains('logIn')));
      failConfigure = false;
      await session.run(
        operation: () async {
          operated = true;
        },
      );
      expect(operated, isTrue);
    },
  );

  test('failed logIn never executes purchase and can retry', () async {
    failLogin = true;
    var purchased = false;
    await expectLater(
      session.run(
        operation: () async {
          purchased = true;
        },
      ),
      throwsA(isA<PlatformException>()),
    );
    expect(purchased, isFalse);
    failLogin = false;
    await session.run(
      operation: () async {
        purchased = true;
      },
    );
    expect(purchased, isTrue);
  });

  test('changed credentials reject old operation and its completion', () async {
    token = 'new-token';
    var purchased = false;
    await expectLater(
      session.run(
        operation: () async {
          purchased = true;
        },
      ),
      throwsA(isA<RevenueCatUnavailableException>()),
    );
    expect(purchased, isFalse);
    expect(calls, isEmpty);
    token = 'token';
    await expectLater(
      session.run(
        operation: () async {
          token = 'new-token';
          return 'old result';
        },
      ),
      throwsA(isA<RevenueCatUnavailableException>()),
    );
  });
}
