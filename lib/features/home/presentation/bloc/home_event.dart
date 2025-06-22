part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class LoadPets extends HomeEvent {}

class LoadMorePets extends HomeEvent {}

class SearchPets extends HomeEvent {
  final String query;

  SearchPets(this.query);
}
