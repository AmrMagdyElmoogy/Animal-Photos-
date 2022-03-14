import 'package:animal_photos/core/failure/failure.dart';
import 'package:animal_photos/features/animal_photos/data/api_client/api_client.dart';
import 'package:animal_photos/features/animal_photos/data/model/animal_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class AnimalRemoteDataSource {
  Future<AnimalModel> getDogs(int number);
  Future<AnimalModel> getBirds(int number);
}

class AnimalRemoteDataSourceImplementation extends AnimalRemoteDataSource {

  final AnimalClient animalClient;

  AnimalRemoteDataSourceImplementation({required this.animalClient});
  @override
  Future<AnimalModel> getBirds(int number) async {
    final response = await animalClient.getPhotos('/birds', number);
    return AnimalModel.fromJson(response);
  }

  @override
  Future<AnimalModel> getDogs(int number) async {
    final response = await animalClient.getPhotos('/shibes', number);
    return AnimalModel.fromJson(response);
  }
}
