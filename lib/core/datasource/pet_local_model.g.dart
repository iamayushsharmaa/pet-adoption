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
      name: fields[1] as String,
      type: fields[2] as String,
      breed: fields[3] as String,
      age: fields[4] as String,
      price: fields[5] as int,
      gender: fields[6] as String,
      imageUrl: fields[7] as String,
      location: fields[8] as String,
      description: fields[9] as String,
      isAdopted: fields[10] as bool,
      isFavorited: fields[11] as bool,
      adoptedAt: fields[12] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, PetLocalModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.breed)
      ..writeByte(4)
      ..write(obj.age)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.gender)
      ..writeByte(7)
      ..write(obj.imageUrl)
      ..writeByte(8)
      ..write(obj.location)
      ..writeByte(9)
      ..write(obj.description)
      ..writeByte(10)
      ..write(obj.isAdopted)
      ..writeByte(11)
      ..write(obj.isFavorited)
      ..writeByte(12)
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
