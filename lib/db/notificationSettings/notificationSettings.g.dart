// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notificationSettings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationSettingsStateAdapter
    extends TypeAdapter<NotificationSettingsState> {
  @override
  final int typeId = 1;

  @override
  NotificationSettingsState read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationSettingsState(
      notifAll: fields[0] as bool,
      notifFirstReport: fields[1] as bool,
      notifLastReport: fields[2] as bool,
      notifOnUpdate: fields[3] as bool,
      notifOnUpwardUpdate: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationSettingsState obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.notifAll)
      ..writeByte(1)
      ..write(obj.notifFirstReport)
      ..writeByte(2)
      ..write(obj.notifLastReport)
      ..writeByte(3)
      ..write(obj.notifOnUpdate)
      ..writeByte(4)
      ..write(obj.notifOnUpwardUpdate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationSettingsStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
