part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEvent {}

class ToggleFavoriteEvent extends FavoriteEvent {
  final String petId;
  ToggleFavoriteEvent(this.petId);
}


