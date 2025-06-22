import 'package:petadoption/core/datasource/pet_local_model.dart';

import '../../data/repository/history_repository.dart';

class MarkPetAsAdopted {
  final HistoryRepository repository;

  MarkPetAsAdopted(this.repository);

  void call(PetLocalModel pet) {
    repository.markPetAsAdopted(pet);
  }
}
