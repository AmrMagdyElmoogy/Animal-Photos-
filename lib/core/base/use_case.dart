import 'package:animal_photos/features/animal_photos/domain/entities/animal_entity.dart';
import 'package:dartz/dartz.dart';

import '../failure/failure.dart';

abstract class UseCase<Type,Params>{
  Future<Either<Failure,AnimalEntity>> call(Params params);
}
