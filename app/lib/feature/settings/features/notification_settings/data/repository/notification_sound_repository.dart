import 'package:eqmonitor/feature/settings/features/notification_settings/data/data_source/notification_sound_data_source.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/custom_notification_sound.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_sound_catalog.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_sound_failure.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_sound_inspection.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/prepared_notification_sound.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_sound_repository.g.dart';

@Riverpod(keepAlive: true)
NotificationSoundRepository notificationSoundRepository(Ref ref) =>
    NotificationSoundRepository(ref.watch(notificationSoundDataSourceProvider));

class NotificationSoundRepository {
  new(this._dataSource);

  final NotificationSoundDataSource _dataSource;
  String? _sourcePath;
  bool _importActive = false;

  Future<NotificationSoundInspection?> pickAndInspect() async {
    if (_importActive) throw const NotificationSoundException(.busy);
    _importActive = true;
    try {
      final source = await _dataSource.pickSource();
      if (source == null) {
        _importActive = false;
        return null;
      }
      final inspection = NotificationSoundInspection.fromJson({
        ...await _dataSource.read(
          'inspect',
          arguments: {'sourcePath': source.path},
        ),
        'sourceDisplayName': source.displayName,
      });
      _sourcePath = source.path;
      return inspection;
    } catch (_) {
      _importActive = false;
      _sourcePath = null;
      rethrow;
    }
  }

  Future<PreparedNotificationSound> prepare({
    required bool trimToMaxDuration,
  }) async {
    final path = _sourcePath;
    if (path == null)
      throw const NotificationSoundException(.sourceUnavailable);
    return PreparedNotificationSound.fromJson(
      await _dataSource.read(
        'prepare',
        arguments: {
          'sourcePath': path,
          'trimToMaxDuration': trimToMaxDuration,
        },
      ),
    );
  }

  Future<CustomNotificationSound> commit({
    required String preparedId,
    required String displayName,
  }) async {
    final sound = CustomNotificationSound.fromJson(
      await _dataSource.read(
        'commit',
        arguments: {
          'id': preparedId,
          'displayName': displayName.trim(),
        },
      ),
    );
    // The importing Action retains ownership until its route cleanup finishes.
    return sound;
  }

  Future<void> discard({String? preparedId}) async {
    try {
      await stopPreview();
      if (preparedId != null) {
        await _dataSource.write('discard', arguments: {'id': preparedId});
      }
    } finally {
      _sourcePath = null;
      _importActive = false;
    }
  }

  Future<List<CustomNotificationSound>> list() async =>
      NotificationSoundCatalog.fromJson(await _dataSource.read('list')).sounds;

  Future<void> rename({required String id, required String displayName}) =>
      _dataSource.write(
        'rename',
        arguments: {'id': id, 'displayName': displayName.trim()},
      );

  Future<void> delete({required String id}) =>
      _dataSource.write('delete', arguments: {'id': id});

  Future<void> previewPrepared({required String preparedId}) => _dataSource
      .write('preview', arguments: {'id': preparedId, 'prepared': true});

  Future<void> previewSaved({required String id}) =>
      _dataSource.write('preview', arguments: {'id': id, 'prepared': false});

  Future<void> stopPreview() => _dataSource.write('stopPreview');
}
