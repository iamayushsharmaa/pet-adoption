import 'package:hive/hive.dart';

import '../../../../core/datasource/pet_local_model.dart';
class HistoryLocalService {
  final Box<PetLocalModel> _box = Hive.box<PetLocalModel>('pets');

  void markAsAdopted(PetLocalModel pet) {
    final existingPet = _box.get(pet.id);

    if (existingPet != null) {
      existingPet
        ..isAdopted = true
        ..adoptedAt = DateTime.now();
      existingPet.save();
    } else {
      _box.put(
        pet.id,
        pet.copyWith(isAdopted: true, adoptedAt: DateTime.now()),
      );
    }
  }

  List<PetLocalModel> getAdoptedPetsChronologically() {
    final adopted = _box.values
        .where((pet) => pet.isAdopted && pet.adoptedAt != null)
        .toList();

    adopted.sort((a, b) => b.adoptedAt!.compareTo(a.adoptedAt!));
    return adopted;
  }
}
