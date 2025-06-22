import '../../data/repository/history_repository.dart';

class MarkPetAsAdopted {
  final HistoryRepository repository;
  MarkPetAsAdopted(this.repository);

  void call(String petId) {
    repository.markPetAsAdopted(petId);
  }
}