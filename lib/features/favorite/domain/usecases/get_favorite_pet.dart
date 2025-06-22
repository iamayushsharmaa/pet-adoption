import 'package:petadoption/core/datasource/pet_local_model.dart';

import '../../data/repository/favorites_repository.dart';

class GetFavoritePets {
  final FavoritesRepository repository;

  GetFavoritePets(this.repository);

  Future<List<PetLocalModel>> call() => repository.getFavoritePets();
}
