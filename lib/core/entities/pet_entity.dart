import '../datasource/pet_local_model.dart';

class PetEntity {
  final String id;
  final String name;
  final String type;
  final String breed;
  final String age;
  final int price;
  final String gender;
  final String imageUrl;
  final String location;
  final String description;
  final bool isAdopted;
  final bool isFavorited;

  PetEntity({
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
  });

  PetEntity copyWith({
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
  }) {
    return PetEntity(
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
    );
  }
}

extension PetLocalModelMapper on PetLocalModel {
  PetEntity toEntity() {
    return PetEntity(
      id: id,
      name: name,
      type: type,
      breed: breed,
      age: age,
      price: price,
      gender: gender,
      imageUrl: imageUrl,
      location: location,
      description: description,
      isAdopted: isAdopted,
      isFavorited: isFavorited,
    );
  }
}
