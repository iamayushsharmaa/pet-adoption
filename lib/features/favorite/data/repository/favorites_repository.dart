import 'package:petadoption/core/datasource/pet_local_model.dart';

abstract class FavoritesRepository {
  Future<List<PetLocalModel>> getFavoritePets();

  Future<void> toggleFavorite(PetLocalModel pet);
}
