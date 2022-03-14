import 'package:animal_photos/core/base/use_case.dart';
import 'package:animal_photos/core/failure/failure.dart';
import 'package:animal_photos/features/animal_photos/domain/entities/animal_entity.dart';
import 'package:animal_photos/features/animal_photos/domain/repository/animal_repository.dart';
import 'package:dartz/dartz.dart';

class GetDogsUseCase extends UseCase<AnimalEntity, int> {
  final AnimalRepository repository;

  GetDogsUseCase({required this.repository});

  @override
  Future<Either<Failure, AnimalEntity>> call(int params) async {
    return await repository.getDogsPhotos(params);
  }
}
