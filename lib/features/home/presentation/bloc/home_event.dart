part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class LoadPets extends HomeEvent{}

class RefreshPets extends HomeEvent{}