import 'package:hive/hive.dart';

import '../../../../core/datasource/pet_local_model.dart';

class FavoritesLocalService {
  final Box<PetLocalModel> _box = Hive.box<PetLocalModel>('pets');

  List<String> getFavoriteIds() {
    return _box.values.where((e) => e.isFavorited).map((e) => e.id).toList();
  }

  void toggleFavorite(String petId) {
    final pet = _box.get(petId);
    if (pet != null) {
      pet.isFavorited = !pet.isFavorited;
      pet.save();
    } else {
      _box.put(petId, PetLocalModel(id: petId, isFavorited: true));
    }
  }
}
