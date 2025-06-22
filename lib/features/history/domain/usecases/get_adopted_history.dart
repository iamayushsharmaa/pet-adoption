import '../../../../core/datasource/pet_local_model.dart';
import '../../data/repository/history_repository.dart';

class GetAdoptedHistory {
  final HistoryRepository repository;

  GetAdoptedHistory(this.repository);

  List<PetLocalModel> call() {
    return repository.getAdoptedHistory();
  }
}
