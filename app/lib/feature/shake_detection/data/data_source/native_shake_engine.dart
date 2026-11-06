import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

final class NativeShakeEngine {
  new _(this.port, this.receive, this.isolate, this.pending);

  final SendPort port;
  final ReceivePort receive;
  final Isolate isolate;
  final Map<int, Completer<Map<String, dynamic>>> pending;
  var sequence = 0;
  var disposed = false;

  static Future<NativeShakeEngine> create({
    required String libraryPath,
    required Map<String, dynamic> config,
  }) async {
    final receive = ReceivePort();
    final ready = Completer<SendPort>();
    final pending = <int, Completer<Map<String, dynamic>>>{};
    receive.listen((message) {
      switch (message) {
        case SendPort():
          if (!ready.isCompleted) ready.complete(message);
        case _Reply(:final id, :final json, :final error):
          final completer = pending.remove(id);
          if (completer == null) return;
          if (error != null) {
            completer.completeError(StateError(error));
          } else if (json != null) {
            completer.complete(jsonDecode(json) as Map<String, dynamic>);
          }
        case _StartupError(:final message):
          if (!ready.isCompleted) ready.completeError(StateError(message));
        case null:
          final error = StateError('Native analysis isolate exited');
          if (!ready.isCompleted) ready.completeError(error);
          for (final completer in pending.values) {
            completer.completeError(error);
          }
          pending.clear();
      }
    });
    final isolate = await Isolate.spawn(
      NativeWorker.run,
      _Startup(receive.sendPort, libraryPath, jsonEncode(config)),
      onExit: receive.sendPort,
      errorsAreFatal: true,
      debugName: 'native_observation_analysis',
    );
    try {
      final port = await ready.future.timeout(const Duration(seconds: 10));
      return NativeShakeEngine._(port, receive, isolate, pending);
    } on Object {
      isolate.kill(priority: Isolate.immediate);
      receive.close();
      rethrow;
    }
  }

  Future<Map<String, dynamic>> request(Map<String, dynamic> value) =>
      send(json: jsonEncode({'schema_version': 1, ...value}));

  Future<Map<String, dynamic>> analyzeGif({
    required Uint8List bytes,
    required Map<String, dynamic> metadata,
  }) =>
      send(json: jsonEncode({'schema_version': 1, ...metadata}), bytes: bytes);

  Future<Map<String, dynamic>> send({required String json, Uint8List? bytes}) {
    if (disposed) return Future.error(StateError('Native analysis disposed'));
    final id = ++sequence;
    final completer = Completer<Map<String, dynamic>>();
    pending[id] = completer;
    port.send(_Command(id, json, bytes));
    return completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        pending.remove(id);
        throw TimeoutException('Native analysis timed out');
      },
    );
  }

  Future<void> dispose() async {
    if (disposed) return;
    disposed = true;
    for (final completer in pending.values) {
      completer.completeError(StateError('Native analysis disposed'));
    }
    pending.clear();
    final stopped = ReceivePort();
    port.send(_Stop(stopped.sendPort));
    try {
      await stopped.first.timeout(const Duration(seconds: 2));
    } on TimeoutException {
      // The worker finishes its bounded call and handles the queued stop itself.
    } finally {
      stopped.close();
      receive.close();
    }
  }
}

final class const _Startup(
  final SendPort reply,
  final String path,
  final String json,
);
final class const _StartupError(final String message);
final class const _Command(
  final int id,
  final String json,
  final Uint8List? bytes,
);
final class const _Reply(
  final int id, {
  final String? json,
  final String? error,
});
final class const _Stop(final SendPort reply);

final class NativeWorker {
  @pragma('vm:entry-point')
  static void run(_Startup startup) {
    try {
      final bindings = NativeBindings(startup.path);
      final handle = bindings.create(startup.json);
      final input = ReceivePort();
      startup.reply.send(input.sendPort);
      input.listen((message) {
        if (message is _Stop) {
          bindings.destroy(handle);
          message.reply.send(true);
          input.close();
        } else if (message is _Command) {
          try {
            final result = bindings.call(
              handle: handle,
              json: message.json,
              gif: message.bytes,
            );
            startup.reply.send(_Reply(message.id, json: result));
          } on Object catch (error) {
            startup.reply.send(_Reply(message.id, error: error.toString()));
          }
        }
      });
    } on Object catch (error) {
      startup.reply.send(_StartupError(error.toString()));
    }
  }
}

final class NativeBuffer extends Struct {
  external Pointer<Uint8> data;
  @Size()
  external int length;
}

final class NativeBindings {
  new(String path)
    : library = path == 'process'
          ? DynamicLibrary.process()
          : DynamicLibrary.open(path) {
    final abi = library.lookupFunction<Uint32 Function(), int Function()>(
      'eqm_abi_version',
    )();
    if (abi != 1) throw StateError('Unsupported native ABI: $abi');
  }
  final DynamicLibrary library;
  late final createNative = library
      .lookupFunction<
        Int32 Function(Pointer<Uint8>, Size, Pointer<Uint64>),
        int Function(Pointer<Uint8>, int, Pointer<Uint64>)
      >('eqm_create');
  late final requestNative = library
      .lookupFunction<
        Int32 Function(Uint64, Pointer<Uint8>, Size, Pointer<NativeBuffer>),
        int Function(int, Pointer<Uint8>, int, Pointer<NativeBuffer>)
      >('eqm_request');
  late final gifNative = library
      .lookupFunction<
        Int32 Function(
          Uint64,
          Pointer<Uint8>,
          Size,
          Pointer<Uint8>,
          Size,
          Pointer<NativeBuffer>,
        ),
        int Function(
          int,
          Pointer<Uint8>,
          int,
          Pointer<Uint8>,
          int,
          Pointer<NativeBuffer>,
        )
      >('eqm_ingest_gif');
  late final freeNative = library
      .lookupFunction<
        Int32 Function(Pointer<NativeBuffer>),
        int Function(Pointer<NativeBuffer>)
      >('eqm_buffer_free');
  late final destroyNative = library
      .lookupFunction<Int32 Function(Uint64), int Function(int)>('eqm_destroy');

  int create(String json) => using((arena) {
    final bytes = utf8.encode(json);
    final input = arena<Uint8>(bytes.length)
      ..asTypedList(bytes.length).setAll(0, bytes);
    final handle = arena<Uint64>();
    check(createNative(input, bytes.length, handle));
    return handle.value;
  });

  String call({required int handle, required String json, Uint8List? gif}) =>
      using((arena) {
        final bytes = utf8.encode(json);
        final input = arena<Uint8>(bytes.length)
          ..asTypedList(bytes.length).setAll(0, bytes);
        final out = arena<NativeBuffer>();
        out.ref.data = nullptr;
        out.ref.length = 0;
        try {
          if (gif == null) {
            check(requestNative(handle, input, bytes.length, out));
          } else {
            final image = arena<Uint8>(gif.length)
              ..asTypedList(gif.length).setAll(0, gif);
            check(
              gifNative(handle, input, bytes.length, image, gif.length, out),
            );
          }
          return utf8.decode(out.ref.data.asTypedList(out.ref.length));
        } finally {
          check(freeNative(out));
        }
      });
  void destroy(int handle) => check(destroyNative(handle));
  void check(int status) {
    if (status != 0) throw StateError('Native analysis status: $status');
  }
}
