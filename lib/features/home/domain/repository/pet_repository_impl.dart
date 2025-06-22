import 'package:petadoption/core/entities/pet_entity.dart';
import 'package:petadoption/features/home/data/repository/pet_repository.dart';

import '../../data/remote/pet_api_service.dart';

class PetRepositoryImpl implements PetRepository {
  final PetApiService _petApiService;

  PetRepositoryImpl(this._petApiService);

  @override
  Future<List<PetEntity>> getAllPets() async {
    return await _petApiService.fetchPets();
  }
}
