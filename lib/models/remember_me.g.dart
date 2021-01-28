// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remember_me.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RememberMeAdapter extends TypeAdapter<RememberMe> {
  @override
  final int typeId = 1;

  @override
  RememberMe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RememberMe(
      rememberMeBool: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, RememberMe obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.rememberMeBool);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RememberMeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
