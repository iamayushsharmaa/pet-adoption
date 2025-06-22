import 'package:hive/hive.dart';

import '../../../../core/entities/pet_entity.dart';

part 'pet_model.g.dart';

@HiveType(typeId: 0)
class PetModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String type;

  @HiveField(3)
  final String breed;

  @HiveField(4)
  final String age;

  @HiveField(5)
  final int price;

  @HiveField(6)
  final String gender;

  @HiveField(7)
  final String imageUrl;

  @HiveField(8)
  final String location;

  @HiveField(9)
  final String description;

  PetModel({
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
  });

  factory PetModel.fromJson(Map<String, dynamic> json) {
    final fallbackId =
        json['name'] ?? DateTime.now().millisecondsSinceEpoch.toString();

    return PetModel(
      id: json['id'] ?? fallbackId,
      name: json['name'] ?? 'Unnamed',
      type: json['type'] ?? '',
      breed: json['breed'] ?? '',
      age: json['age'] ?? '',
      price: (json['price'] ?? 0),
      gender: json['gender'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      location: json['location'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'breed': breed,
      'age': age,
      'price': price,
      'gender': gender,
      'imageUrl': imageUrl,
      'location': location,
      'description': description,
    };
  }

  PetEntity toEntity({bool isAdopted = false, bool isFavorited = false}) {
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
