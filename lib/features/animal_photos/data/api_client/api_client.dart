import 'package:dio/dio.dart';

class AnimalClient {

  late Dio dio;
  AnimalClient()
  {
    dio =  Dio(BaseOptions(
    baseUrl: 'http://shibe.online/api',
    sendTimeout: 3000,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ));
  }
   Future<List<dynamic>> getPhotos(String path, int number) async {
    final response = await dio.get(path, queryParameters: {
      'count': number,
      'urls': true,
    });
    // print(response.data);
    return response.data;
  }
}
