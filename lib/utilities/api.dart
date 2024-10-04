import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Api {
  call(url, data, callback) async {
    Uri fullUrl = Uri.parse(url);
    var setHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    try {
      http.Response response = await http
          .post(
            fullUrl,
            body: jsonEncode(data),
            headers: setHeaders,
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        callback(
          true,
          // ignore: unnecessary_null_comparison
          (response == null) ? null : jsonDecode(response.body),
        );
      } else if (response.statusCode == 204) {
        callback(true, null);
      } else {
        var resError = jsonDecode(response.body);
        callback(false, resError['Errors'][0]['Message']);
      }
    } on TimeoutException catch (_) {
      callback(false, "Server Time Out");
    } on SocketException catch (_) {
      callback(false, "Connection Failed");
    }
  }
}
