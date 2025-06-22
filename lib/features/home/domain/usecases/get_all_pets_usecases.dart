import '../../../../core/entities/pet_entity.dart';
import '../../data/repository/pet_repository.dart';

class GetAllPetsUseCase {
  final PetRepository repository;

  GetAllPetsUseCase(this.repository);

  Future<List<PetEntity>> call({int page = 1, int limit = 10}) {
    return repository.getAllPets(page: page, limit: limit);
  }
}