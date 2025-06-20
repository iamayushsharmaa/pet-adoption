class PetEntity {
  final String id;
  final String name;
  final String type;
  final String breed;
  final String age;
  final double price;
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
}
