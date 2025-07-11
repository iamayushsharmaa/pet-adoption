import 'package:hive/hive.dart';

import '../../../../core/datasource/pet_local_model.dart';

class FavoritesLocalService {
  Box<PetLocalModel> get _box => Hive.box<PetLocalModel>('petStatus');

  List<PetLocalModel> getFavoritePets() {
    return _box.values.where((e) => e.isFavorited).toList();
  }

  void toggleFavorite(PetLocalModel pet) {
    final existing = _box.get(pet.id);

    if (existing != null) {
      existing.isFavorited = !existing.isFavorited;
      existing.save();
    } else {
      pet.isFavorited = true;
      _box.put(pet.id, pet);
    }
  }
}
