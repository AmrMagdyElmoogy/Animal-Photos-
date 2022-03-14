import 'package:animal_photos/core/failure/exceptions.dart';
import 'package:animal_photos/core/failure/failure.dart';
import 'package:animal_photos/core/input_converter/input_converter.dart';
import 'package:animal_photos/features/animal_photos/domain/entities/animal_entity.dart';
import 'package:animal_photos/features/animal_photos/domain/use_case/getBirdsPhotos.dart';
import 'package:animal_photos/features/animal_photos/domain/use_case/getDogsPhotos.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
part 'animal_event.dart';
part 'animal_state.dart';

const cacheError = 'Cache Error!';
const serverError = 'Server Error!';
const invalidInput = 'Invalid Input, Please enter an integer between 1 to 100';

class AnimalBloc extends Bloc<AnimalEvent, AnimalState> {
  final GetBirdsUseCase birds;
  final GetDogsUseCase dogs;
  final InputConverter converter;

  AnimalBloc({required this.birds, required this.dogs, required this.converter})
      : super(AnimalInitial()) {
    on<GetBirdsPhotosEvent>((event, emit) async {
      emit(Loading());
      try {
        int number = converter.convertToInteger(event.numberOfPhotos);
        final eitherBird = await birds(number);
        eitherBird.fold((failure) {
          emit(Error(message: _cacheOrServer(failure)));
        }, (birds) {
          emit(Loaded(entity: birds));
        });
      } on InvalidFormatException {
        emit(const Error(message: invalidInput));
      }
    });

    on<GetDogsPhotosEvent>((event, emit) async {
      emit(Loading());
      try {
        int number = converter.convertToInteger(event.numberOfPhotos);
        final eitherDogs = await dogs(number);
        eitherDogs.fold((failure) {
          emit(Error(message: _cacheOrServer(failure)));
        }, (dogs) {
          emit(Loaded(entity: dogs));
        });
      } on InvalidFormatException {
        emit(const Error(message: invalidInput));
      }
    });
  }

  String _cacheOrServer(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'LOL';
      case CacheFailure:
        return 'LOLLL';
      default:
        return 'Unexpected Error';
    }
  }
}
