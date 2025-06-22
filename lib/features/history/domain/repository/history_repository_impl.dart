import '../../../../core/datasource/pet_local_model.dart';
import '../../data/local/history_local_service.dart';
import '../../data/repository/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryLocalService localService;

  HistoryRepositoryImpl(this.localService);

  @override
  void markPetAsAdopted(String petId) {
    localService.markAsAdopted(petId);
  }

  @override
  List<PetLocalModel> getAdoptedHistory() {
    return localService.getAdoptedPetsChronologically();
  }
}
