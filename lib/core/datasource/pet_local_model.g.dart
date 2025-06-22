// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PetLocalModelAdapter extends TypeAdapter<PetLocalModel> {
  @override
  final int typeId = 1;

  @override
  PetLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PetLocalModel(
      id: fields[0] as String,
      isAdopted: fields[1] as bool,
      isFavorited: fields[2] as bool,
      adoptedAt: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, PetLocalModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isAdopted)
      ..writeByte(2)
      ..write(obj.isFavorited)
      ..writeByte(3)
      ..write(obj.adoptedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PetLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
