// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PetLocalModelAdapter extends TypeAdapter<PetLocalModel> {
  @override
  final int typeId = 0;

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
    );
  }

  @override
  void write(BinaryWriter writer, PetLocalModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isAdopted)
      ..writeByte(2)
      ..write(obj.isFavorited);
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
