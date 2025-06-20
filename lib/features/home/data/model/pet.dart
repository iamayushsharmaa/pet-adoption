class PetModel {
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
    return PetModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      breed: json['breed'] ?? '',
      age: json['age'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      gender: json['gender'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      location: json['location'] ?? '',
      description: json['description'] ?? '',
    );
  }

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
