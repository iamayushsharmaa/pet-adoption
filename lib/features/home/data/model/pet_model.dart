import 'package:hive/hive.dart';

import '../../../../core/entities/pet_entity.dart';

part 'pet_model.g.dart';

@HiveType(typeId: 0)
class PetModel extends PetEntity {
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
  final double price;

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
  }) : super(
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
       );

  factory PetModel.fromJson(Map<String, dynamic> json) => PetModel(
    id: json['id'],
    name: json['name'],
    type: json['type'],
    breed: json['breed'],
    age: json['age'],
    price: (json['price'] as num).toDouble(),
    gender: json['gender'],
    imageUrl: json['imageUrl'],
    location: json['location'],
    description: json['description'],
  );

  Map<String, dynamic> toJson() => {
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
