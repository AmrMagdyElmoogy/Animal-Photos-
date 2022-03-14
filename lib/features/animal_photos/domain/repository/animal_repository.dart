import 'package:animal_photos/features/animal_photos/domain/entities/animal_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';

abstract class AnimalRepository {
  Future<Either<Failure, AnimalEntity>> getDogsPhotos(int numberOfPhotos);
  Future<Either<Failure, AnimalEntity>> getBirdsPhotos(int numberOfPhotos);
}
