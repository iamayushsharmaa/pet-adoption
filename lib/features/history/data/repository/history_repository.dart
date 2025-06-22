import '../../../../core/datasource/pet_local_model.dart';

abstract class HistoryRepository {
  void markPetAsAdopted(String petId);

  List<PetLocalModel> getAdoptedHistory();
}
