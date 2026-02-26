// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasbih_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TasbihModelAdapter extends TypeAdapter<TasbihModel> {
  @override
  final int typeId = 1;

  @override
  TasbihModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TasbihModel(
      phrase: fields[0] as String,
      currentCount: fields[1] as int,
      totalRounds: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TasbihModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.phrase)
      ..writeByte(1)
      ..write(obj.currentCount)
      ..writeByte(2)
      ..write(obj.totalRounds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TasbihModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
