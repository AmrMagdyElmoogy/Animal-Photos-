import 'package:animal_photos/core/failure/exceptions.dart';
import 'package:animal_photos/core/network/network_info.dart';
import 'package:animal_photos/features/animal_photos/data/data_source/animal_local_source.dart';
import 'package:animal_photos/features/animal_photos/data/data_source/animal_remote_source.dart';
import 'package:animal_photos/features/animal_photos/domain/entities/animal_entity.dart';
import 'package:animal_photos/core/failure/failure.dart';
import 'package:animal_photos/features/animal_photos/domain/repository/animal_repository.dart';
import 'package:dartz/dartz.dart';

class AnimalRepositoryImplementaion extends AnimalRepository {
  final NetworkInfo network;
  final AnimalRemoteDataSource remote;
  final AnimalLocalDataSource local;

  AnimalRepositoryImplementaion(
      {required this.network, required this.remote, required this.local});

  @override
  Future<Either<Failure, AnimalEntity>> getBirdsPhotos(
      int numberOfPhotos) async {
    if (await network.isConnected()) {
      try {
        final birdsUrlPhotos = await remote.getBirds(numberOfPhotos);
        local.cacheBirdsUrls(birdsUrlPhotos);
        return Right(birdsUrlPhotos);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final birdsUrlCached =  local.getBirdsUrlsCached();
        return Right(birdsUrlCached);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, AnimalEntity>> getDogsPhotos(
      int numberOfPhotos) async {
    if (await network.isConnected()) {
      try {
        final dogsUrlPhotos = await remote.getDogs(numberOfPhotos);
        //here
        local.cacheDogsUrls(dogsUrlPhotos);
        return Right(dogsUrlPhotos);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final dogsUrlPhotos = local.getDogsUrlsCached();
        return Right(dogsUrlPhotos);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

}
