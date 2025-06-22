part of 'adopt_bloc.dart';

abstract class AdoptionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdoptionInitial extends AdoptionState {}

class AdoptionLoading extends AdoptionState {}

class AdoptionSuccess extends AdoptionState {}

class AdoptionFailure extends AdoptionState {
  final String message;

  AdoptionFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class AdoptionHistoryLoaded extends AdoptionState {
  final List<PetLocalModel> pets;

  AdoptionHistoryLoaded(this.pets);

  @override
  List<Object?> get props => [pets];
}
