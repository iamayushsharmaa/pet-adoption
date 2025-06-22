part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}
final class Success extends FavoriteState {}
final class Error extends FavoriteState {}
