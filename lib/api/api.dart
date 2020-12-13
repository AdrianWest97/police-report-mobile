import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:prms/utils/SharedPrefs.dart';

class Network {
  //base  url
  final String url = DotEnv().env['APP_URL'];

//set header and specify content type
  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${sharedPrefs.token}'
      };

//post reques to api
  postData(data, apiUrl) async {
    var fullUrl = url + apiUrl;
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

//delete request to api
  deleteData(apiUrl) async {
    var fullUrl = url + apiUrl;
    return await http.delete(fullUrl, headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = url + apiUrl;
    return await http.get(
      fullUrl,
      headers: _setHeaders(),
    );
  }

  fetch(apiUrl) async {
    var fullUrl = url + apiUrl;
    //return data from api
    return await http.get(
      fullUrl,
      headers: _setHeaders(),
    );
  }
}
