import 'package:http/http.dart';

class HttpLogger {
  static void log(Response response) {
    print(
      'URL : ${response.request?.url} -- StatusCode : ${response.statusCode} -- reasonPhrase : ${response.reasonPhrase}',
    );
  }
}
