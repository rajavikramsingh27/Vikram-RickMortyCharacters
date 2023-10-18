
import 'package:http/http.dart' as http;

String get kBaseURL {
  return 'https://rickandmortyapi.com/api/';
}

class API {
  final String url;

  API({required this.url});

  Future<http.Response> get() async {
    // if (!await CheckInternet.checkInternet()) {
    //   return null;
    // }

    print(url);

    try {
      final response = await http.get(Uri.parse(url)).timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          String internetConnectPoorBody = 'Internet connection is poor.';
          int internetConnectPoorCode = 1111;

          return http.Response(internetConnectPoorBody, internetConnectPoorCode);
        },
      );

      return response;
    } catch (error) {
      int apiExceptionCode = 1112;

      final response = http.Response(error.toString(), apiExceptionCode);
      return response;
    }
  }

}

