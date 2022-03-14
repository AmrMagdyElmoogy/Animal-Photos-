import 'package:animal_photos/core/failure/failure.dart';
import 'package:animal_photos/features/animal_photos/domain/entities/animal_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/animal_model.dart';

abstract class AnimalLocalDataSource {
  Future<void> cacheBirdsUrls(AnimalModel model);
  Future<void> cacheDogsUrls(AnimalModel model);
  AnimalModel getBirdsUrlsCached();
  AnimalModel getDogsUrlsCached();
}

const cachedBirds = 'CachedBirds';
const cachedDogs = 'CachedDogs';

class AnimalLoaclDataSourceImplementaion extends AnimalLocalDataSource {
  final SharedPreferences preferences;

  AnimalLoaclDataSourceImplementaion(
      { required this.preferences});
  @override
  AnimalModel getBirdsUrlsCached() {
    final list = preferences.getStringList(cachedBirds);
    if (list != null) {
      return AnimalModel.fromJson(list);
    } else {
      throw CacheFailure();
    }
  }

  @override
  AnimalModel getDogsUrlsCached() {
    final list = preferences.getStringList(cachedDogs);

    if (list != null) {
      return AnimalModel.fromJson(list);
    } else {
      throw CacheFailure();
    }
  }

  @override
  Future<void> cacheBirdsUrls(AnimalModel model) async {
    final list = model.toJson(model);
    await preferences.setStringList(cachedBirds, list);
  }

  @override
  Future<void> cacheDogsUrls(AnimalModel model) async {
    final list = model.toJson(model);
    await preferences.setStringList(cachedDogs, list);
  }
}
