import 'package:get/get.dart';

class ApiClient extends GetConnect {
  final String _apiKey = 'TRKyyV2Q3WtIfZNWuYoLNtXE1qFUk7f8JFi96xrJ';

  Future<Response> fetchMarsPhotos() async {
    final String url =
        'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&camera=FHAZ&api_key=$_apiKey&page=1';

    try {
      final response = await get(url);

      if (response.isOk) {
        return response;
      } else {
        print('Error: ${response.statusText}');
        throw Exception('Failed to load Mars photos');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Error fetching Mars photos');
    }
  }
}