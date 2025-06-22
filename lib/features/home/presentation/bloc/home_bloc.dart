import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:petadoption/core/entities/pet_entity.dart';

import '../../domain/usecases/get_all_pets_usecases.dart';

part 'home_event.dart';
part 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllPetsUseCase getAllPets;
  int _currentPage = 1;
  final int _limit = 10;
  bool _isLoadingMore = false;
  bool _hasReachedEnd = false;
  List<PetEntity> _allPets = [];

  HomeBloc(this.getAllPets) : super(HomeInitial()) {
    on<LoadPets>(_onLoadPets);
    on<LoadMorePets>(_onLoadMorePets);
    on<SearchPets>(_onSearchPets);
  }

  Future<void> _onLoadPets(LoadPets event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    _currentPage = 1;
    _hasReachedEnd = false;
    try {
      final pets = await getAllPets(page: _currentPage, limit: _limit);
      _allPets = pets;
      if (pets.length < _limit) _hasReachedEnd = true;
      emit(HomeLoaded(_allPets));
    } catch (_) {
      emit(HomeError("Failed to load pets"));
    }
  }

  Future<void> _onLoadMorePets(LoadMorePets event, Emitter<HomeState> emit) async {
    if (_isLoadingMore || _hasReachedEnd) return;

    _isLoadingMore = true;
    emit(HomeLoaded(_allPets, isLoadingMore: true));

    try {
      _currentPage++;
      final newPets = await getAllPets(page: _currentPage, limit: _limit);

      if (newPets.isEmpty || newPets.length < _limit) {
        _hasReachedEnd = true;
      }

      _allPets.addAll(newPets);
      emit(HomeLoaded(List.from(_allPets)));
    } catch (_) {
      emit(HomeError("Failed to load more pets"));
    }

    _isLoadingMore = false;
  }

  void _onSearchPets(SearchPets event, Emitter<HomeState> emit) {
    final query = event.query.toLowerCase();

    final filtered = _allPets.where((pet) {
      return pet.name.toLowerCase().contains(query) ||
          pet.breed.toLowerCase().contains(query) ||
          pet.type.toLowerCase().contains(query);
    }).toList();

    emit(HomeLoaded(filtered));
  }
}
