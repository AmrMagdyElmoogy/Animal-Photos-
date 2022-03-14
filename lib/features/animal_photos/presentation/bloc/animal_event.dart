part of 'animal_bloc.dart';

abstract class AnimalEvent extends Equatable {
  const AnimalEvent();

  @override
  List<Object> get props => [];
}

class GetDogsPhotosEvent extends AnimalEvent {
  final String numberOfPhotos;

  const GetDogsPhotosEvent({required this.numberOfPhotos});
  @override
  List<Object> get props => [numberOfPhotos];
}

class GetBirdsPhotosEvent extends AnimalEvent {
  final String numberOfPhotos;

  const GetBirdsPhotosEvent({required this.numberOfPhotos});
  @override
  List<Object> get props => [numberOfPhotos];
}
