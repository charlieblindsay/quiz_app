import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {

  final String url;

  NetworkHelper(String this.url);

  Future getData() async{
    Uri parsedUrl = Uri.parse(url);
    http.Response response = await http.get(parsedUrl);

    if (response.statusCode == 200){
      String data = response.body;

      return jsonDecode(data);
    }
    else{
      print(response.statusCode);
    }
  }
}
