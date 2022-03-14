import 'package:animal_photos/features/animal_photos/domain/entities/animal_entity.dart';

class AnimalModel extends AnimalEntity {
  const AnimalModel({required List<String> urls}) : super(urls: urls);

  factory AnimalModel.fromJson(List<dynamic> json) {
    List<String> url = [];
    for(int i=0; i<json.length;i++)
    {
      url.add(json[i]);
    }

    return AnimalModel(urls: url);
  }

  List<String> toJson(AnimalModel model) {
    return urls;
  }
}
