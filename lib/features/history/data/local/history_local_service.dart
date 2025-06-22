import 'package:hive/hive.dart';

import '../../../../core/datasource/pet_local_model.dart';

class HistoryLocalService {
  final Box<PetLocalModel> _box = Hive.box<PetLocalModel>('pets');

  void markAsAdopted(String petId) {
    final pet = _box.get(petId);
    if (pet != null) {
      pet.isAdopted = true;
      pet.adoptedAt = DateTime.now();
      pet.save();
    } else {
      _box.put(
        petId,
        PetLocalModel(id: petId, isAdopted: true, adoptedAt: DateTime.now()),
      );
    }
  }

  List<PetLocalModel> getAdoptedPetsChronologically() {
    final adopted = _box.values
        .where((pet) => pet.isAdopted && pet.adoptedAt != null)
        .toList();

    adopted.sort(
      (a, b) => b.adoptedAt!.compareTo(a.adoptedAt!),
    ); // newest first
    return adopted;
  }
}
