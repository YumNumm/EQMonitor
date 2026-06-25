import 'dart:convert';

import 'package:cache/src/database/http_cache_database.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CacheDatabase db;

  setUp(() => db = CacheDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  HttpCacheEntriesCompanion entry(String key, {int status = 200, String? eTag}) =>
      HttpCacheEntriesCompanion.insert(
        key: key,
        statusCode: status,
        eTag: Value(eTag),
        headers: jsonEncode(<String, List<String>>{}),
        responseType: 'json',
        body: Uint8List.fromList(utf8.encode('{}')),
        updatedAtMs: 0,
      );

  test('putEntry then getEntry returns the row', () async {
    await db.putEntry(entry('k1', eTag: 'W/"a"'));
    final row = await db.getEntry('k1');
    expect(row, isNotNull);
    expect(row!.eTag, 'W/"a"');
  });

  test('putEntry replaces on same key', () async {
    await db.putEntry(entry('k1'));
    await db.putEntry(entry('k1', status: 201));
    final row = await db.getEntry('k1');
    expect(row!.statusCode, 201);
  });

  test('getEntry returns null for missing key', () async {
    expect(await db.getEntry('nope'), isNull);
  });

  test('deleteEntry removes only that key', () async {
    await db.putEntry(entry('k1'));
    await db.putEntry(entry('k2'));
    await db.deleteEntry('k1');
    expect(await db.getEntry('k1'), isNull);
    expect(await db.getEntry('k2'), isNotNull);
  });

  test('clear removes all', () async {
    await db.putEntry(entry('k1'));
    await db.putEntry(entry('k2'));
    await db.clear();
    expect(await db.getEntry('k1'), isNull);
    expect(await db.getEntry('k2'), isNull);
  });
}
