part of 'favorite_bloc.dart';

abstract class FavoritesEvent {}

class LoadFavorites extends FavoritesEvent {}

class ToggleFavoritePet extends FavoritesEvent {
  final PetLocalModel pet;

  ToggleFavoritePet(this.pet);
}
