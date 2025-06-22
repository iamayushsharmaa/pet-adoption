import 'package:hive/hive.dart';

part 'pet_local_model.g.dart';

@HiveType(typeId: 1)
class PetLocalModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  bool isAdopted;

  @HiveField(2)
  bool isFavorited;

  @HiveField(3)
  DateTime? adoptedAt;

  PetLocalModel({
    required this.id,
    this.isAdopted = false,
    this.isFavorited = false,
    this.adoptedAt,
  });
}
