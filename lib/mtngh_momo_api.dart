library mtngh_momo_api;

import 'dart:convert';
import 'package:http/http.dart' as http;


class MTNGhMomo{
  // String TOKEN_KEY = getTokenKey().then((value) => value);
  static String SUBSCRIPTION_KEY = "6ce2769ab2e84acfa01bfd3b7f808bb3";
  //todo add user creation

  Future<Map<String,dynamic>> checkBalance(String number) async{
    // var uri = Uri(
    //   scheme: 'https',
    //   host: 'sandbox.momodeveloper.mtn.com',
    //   path: "collection/v1_0/account/balance",
    //   userInfo: SUBSCRIPTION_KEY,
    //   queryParameters: {
    //     "Subscription Key" : SUBSCRIPTION_KEY
    //   }
    //   // fragment: 'baz',
    //   // queryParameters: _yourQueryParameters,
    // );
    http.Response data = await http.get("https://sandbox.momodeveloper.mtn.com/collection/v1_0/account/balance",

        headers: {
          "X-Target-Environment" : "sandbox",
          // "Authorization" : "BASIC ${TOKEN_KEY}",
          "AccountHolderId" : "",
          "AccountHolderType" : "msisdn",
          "currency" :"GHC",
          "Ocp-Apim-Subscription-Key": SUBSCRIPTION_KEY,
    }
    );
    // http.Response data = await http.get(uri);

    Map json = jsonDecode(data.body);

    return json;
    //todo always regenerate access token and UUID
  }





  Future<String> getTokenKey() async{
    var request = http.Request('POST', Uri.parse('https://sandbox.momodeveloper.mtn.com/collection/token/'));

    request.headers.addAll({
      'Ocp-Apim-Subscription-Key': '6ce2769ab2e84acfa01bfd3b7f808bb3',
      'Authorization': 'Basic ZmM2YTM2NTUtYWNhNy00MDhkLWE1ZGItMmFhNTcyYTJjMTZkOmE0Nzk5Mzk5NGVkZjRmY2I4ZTBkYjE3NDNhNWY0ZWUy'
    });

    http.StreamedResponse response = await request.send();
    String data = await response.stream.bytesToString();
    // response.stream.bytesToString().then((value) => data = value);
    data = json.decode(data)["access_tdoken"];
    return data;
    // return json.decode(response.stream.bytesToString().toString())["access_token"];
    // return response.stream.bytesToString();
  }





  Future<String> generateUUID() async{
    http.Response data = await http.get("https://www.uuidgenerator.net/api/version4");
    
    return data.body;
  }






  makePayment() {

    // var uri = Uri(
    //   scheme: 'https',
    //   host: 'example.com',
    //   path: '/foo/bar',
    //   fragment: 'baz',
    //   queryParameters: _yourQueryParameters,
    // );
    //
    // var response = await http.get(uri);
    // if (response.statusCode == 200) {
    //   var json = jsonDecode(response.body);
    //   // Do whatever you want to do with json.
    // }
  }

  requestPayment() {
  }



}


