import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xhat_app/models/image_model.dart';

class ImageRepository {
  Future<List<PixelformImage>> getNetworkImages() async {
    try {
      var endpointUrl = Uri.parse('https://pixelford.com/api2/images');

      final response = await http.get(endpointUrl);

      if (response.statusCode == 200) {
        final List<dynamic> decodedList = jsonDecode(response.body) as List;

        final List<PixelformImage> _imageList = decodedList.map((listItem) {
          return PixelformImage.fromJson(listItem);
        }).toList();

        print(_imageList[0].urlFullSize);
        return _imageList;
      } else {
        throw Exception('API not successful!');
      }
    } on SocketException {
      throw Exception('No internet connection :(');
    } on HttpException {
      throw Exception('Couldnt retrieve the images! Sorry!');
    } on FormatException {
      throw Exception('Bad response format!');
    } catch (e) {
      print(e);
      throw Exception('Unknown error');
    }
  }
}
