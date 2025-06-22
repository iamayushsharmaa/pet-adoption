import 'package:hive/hive.dart';

import '../entities/pet_entity.dart';

part 'pet_local_model.g.dart';

@HiveType(typeId: 1)
class PetLocalModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String type;

  @HiveField(3)
  String breed;

  @HiveField(4)
  String age;

  @HiveField(5)
  int price;

  @HiveField(6)
  String gender;

  @HiveField(7)
  String imageUrl;

  @HiveField(8)
  String location;

  @HiveField(9)
  String description;

  @HiveField(10)
  bool isAdopted;

  @HiveField(11)
  bool isFavorited;

  @HiveField(12)
  DateTime? adoptedAt;

  PetLocalModel({
    required this.id,
    required this.name,
    required this.type,
    required this.breed,
    required this.age,
    required this.price,
    required this.gender,
    required this.imageUrl,
    required this.location,
    required this.description,
    this.isAdopted = false,
    this.isFavorited = false,
    this.adoptedAt,
  });

  static PetLocalModel fromEntity(PetEntity pet) {
    return PetLocalModel(
      id: pet.id,
      name: pet.name,
      type: pet.type,
      breed: pet.breed,
      age: pet.age,
      price: pet.price,
      gender: pet.gender,
      imageUrl: pet.imageUrl,
      location: pet.location,
      description: pet.description,
      isAdopted: pet.isAdopted,
      isFavorited: pet.isFavorited,
    );
  }

  PetLocalModel copyWith({
    String? id,
    String? name,
    String? type,
    String? breed,
    String? age,
    int? price,
    String? gender,
    String? imageUrl,
    String? location,
    String? description,
    bool? isAdopted,
    bool? isFavorited,
    DateTime? adoptedAt,
  }) {
    return PetLocalModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      breed: breed ?? this.breed,
      age: age ?? this.age,
      price: price ?? this.price,
      gender: gender ?? this.gender,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
      description: description ?? this.description,
      isAdopted: isAdopted ?? this.isAdopted,
      isFavorited: isFavorited ?? this.isFavorited,
      adoptedAt: adoptedAt ?? this.adoptedAt,
    );
  }
}
