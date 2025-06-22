import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/datasource/pet_local_model.dart';
import '../../domain/usecases/get_adopted_history.dart';
import '../../domain/usecases/mark_pet_adopted.dart';

part 'adopt_event.dart';
part 'adopt_state.dart';

class AdoptionBloc extends Bloc<AdoptionEvent, AdoptionState> {
  final MarkPetAsAdopted markPetAsAdopted;
  final GetAdoptedHistory getAdoptedHistory;

  AdoptionBloc({
    required this.markPetAsAdopted,
    required this.getAdoptedHistory,
  }) : super(AdoptionInitial()) {
    on<AdoptPet>(_onAdoptPet);
    on<LoadAdoptedPets>(_onLoadAdoptedPets);
  }

  Future<void> _onAdoptPet(AdoptPet event, Emitter<AdoptionState> emit) async {
    emit(AdoptionLoading());
    try {
      markPetAsAdopted(event.pet);
      emit(AdoptionSuccess());
    } catch (e) {
      emit(AdoptionFailure("Failed to mark pet as adopted"));
    }
  }

  Future<void> _onLoadAdoptedPets(LoadAdoptedPets event, Emitter<AdoptionState> emit) async {
    emit(AdoptionLoading());
    try {
      final pets = getAdoptedHistory();
      emit(AdoptionHistoryLoaded(pets));
    } catch (e) {
      emit(AdoptionFailure("Failed to load adopted pets"));
    }
  }
}