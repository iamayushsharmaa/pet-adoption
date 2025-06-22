import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:petadoption/core/entities/pet_entity.dart';

import '../../domain/usecases/get_all_pets_usecases.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllPetsUseCase getAllPets;

  HomeBloc(this.getAllPets) : super(HomeInitial()) {
    on<LoadPets>(_onLoadPets);
    on<RefreshPets>(_onRefreshPets);
  }

  Future<void> _onLoadPets(LoadPets event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final pets = await getAllPets();
      emit(HomeLoaded(pets));
    } catch (_) {
      emit(HomeError('Failed to load pets'));
    }
  }

  Future<void> _onRefreshPets(
    RefreshPets event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final pets = await getAllPets();
      emit(HomeLoaded(pets));
    } catch (_) {
      emit(HomeError('Failed to refresh pets'));
    }
  }
}
