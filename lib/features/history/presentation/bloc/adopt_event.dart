part of 'adopt_bloc.dart';

abstract class AdoptionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdoptPet extends AdoptionEvent {
  final PetLocalModel pet;

  AdoptPet(this.pet);

  @override
  List<Object?> get props => [pet];
}

class LoadAdoptedPets extends AdoptionEvent {}
