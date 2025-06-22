import '../../../../core/datasource/pet_local_model.dart';

abstract class HistoryRepository {
  void markPetAsAdopted(PetLocalModel pet);

  List<PetLocalModel> getAdoptedHistory();
}
