import '../../../../core/entities/pet_entity.dart';

abstract class PetRepository {
  Future<List<PetEntity>> getAllPets({int page, int limit});
}
