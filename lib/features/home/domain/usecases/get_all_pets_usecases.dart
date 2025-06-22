import '../../../../core/entities/pet_entity.dart';
import '../../data/repository/pet_repository.dart';

class GetAllPetsUseCase {
  final PetRepository repository;

  GetAllPetsUseCase(this.repository);

  Future<List<PetEntity>> call() {
    return repository.getAllPets();
  }
}
