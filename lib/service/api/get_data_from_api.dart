import 'dart:convert';

import 'package:demo_project/views/constants/constants.dart';
import 'package:demo_project/service/models/response_model_single.dart';
import 'package:http/http.dart' as http;

import '../models/response_model_twopart.dart';

class GetDataFromApi {
  var client = http.Client();
  late ResponseModel responseModel;
  late ResponseModel2 responseModel2;
  getResponse(String urlString, String mode) async {
    // Setting Joke Type Mode
    modeAllTime = mode;

    Uri url = Uri.parse(urlString);
    var response = await client.get(url);
    // Response response = await Dio().get(
    //     "https://v2.jokeapi.dev/joke/Any?blacklistFlags=nsfw,religious,racist,sexist");
    if (mode == "single") {
      // debugPrint("Response Body");
      // debugPrint(response.body);
      responseModel = ResponseModel.fromJson(json.decode(response.body));
      joke = responseModel.joke;
    } else {
      responseModel2 = ResponseModel2.fromJson(jsonDecode(response.body));
      twopart = "${responseModel2.setup}\n\n${responseModel2.delivery}";
    }
  }
}
