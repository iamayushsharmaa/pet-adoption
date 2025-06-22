import 'package:hive/hive.dart';
import 'package:petadoption/core/entities/pet_entity.dart';
import 'package:petadoption/features/home/data/repository/pet_repository.dart';

import '../../../../core/datasource/pet_local_model.dart';
import '../../data/remote/pet_api_service.dart';

class PetRepositoryImpl implements PetRepository {
  final PetApiService _petApiService;

  PetRepositoryImpl(this._petApiService);

  @override
  Future<List<PetEntity>> getAllPets({int page = 1, int limit = 10}) async {
    final petModels = await _petApiService.fetchPets(page: page, limit: limit);
    final statusBox = Hive.box<PetLocalModel>('petStatus');

    return petModels.map((pet) {
      final status = statusBox.get(pet.id);

      return PetEntity(
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
        isAdopted: status?.isAdopted ?? false,
        isFavorited: status?.isFavorited ?? false,
      );
    }).toList();
  }
}
