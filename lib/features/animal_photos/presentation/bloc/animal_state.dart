part of 'animal_bloc.dart';

abstract class AnimalState extends Equatable {
  const AnimalState();

  @override
  List<Object> get props => [];
}

class AnimalInitial extends AnimalState {}

class Loading extends AnimalState {
  final String message = 'Wait a white';
  @override
  List<Object> get props => [];
}

class Loaded extends AnimalState {
  final AnimalEntity entity;
  const Loaded({required this.entity});
}

class Error extends AnimalState {
  final String message;
  const Error({required this.message});
}
