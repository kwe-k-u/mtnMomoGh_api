library mtngh_momo_api;

import 'dart:convert';
import 'package:http/http.dart' as http;


class MTNGhMomo{
  String TOKEN_KEY; //TODO integrate with code
  static String SUBSCRIPTION_KEY = "6ce2769ab2e84acfa01bfd3b7f808bb3";

  //todo add user creation

  Future<Map<String,dynamic>> checkBalance(String number) async{
    http.Response data = await http.get("https://sandbox.momodeveloper.mtn.com/collection/v1_0/account/balance",

        headers: {
          "X-Target-Environment" : "sandbox",
          "Authorization" : "BASIC ${getAccessToken()}",
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





  Future<String> getAccessToken() async{
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


  createUser() async{
    var headers = {
      'X-Reference-Id': 'fc6a3655-aca7-408d-a5db-2aa572a2c16d',
      'Ocp-Apim-Subscription-Key': '6ce2769ab2e84acfa01bfd3b7f808bb3',
      'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSMjU2In0.eyJjbGllbnRJZCI6ImZjNmEzNjU1LWFjYTctNDA4ZC1hNWRiLTJhYTU3MmEyYzE2ZCIsImV4cGlyZXMiOiIyMDIwLTEyLTExVDEwOjAzOjUzLjE2OSIsInNlc3Npb25JZCI6ImMyNGRlZDY0LTM4ZDctNGZhYi1hZWNmLTIyNTI1Y2JmMDljNyJ9.jsLfOhXDPvslwvqZJWiEODni7Rb4DQ7Ff4H8rJytEzF8YweaIp2Dy46SqDJnRohWhJd8JHxLw_tOyoU-hFeEo_MEz5JQJXcxZO4gsexCA6JZgqxDLb3nUwGwY8NJ6Of74pA9hsmaBxnWH8m8v_CctraAWCOEdMC2Yq9hLtW7tlyYJdjzfDc-HUfle_HLNZb91Lmq4tyqZXVh6l_1w0fgmRdfZb16OBublONtlRL9ecch-bhGyJlLHWHUYhC4f5p-lHb4rL1bIw-PKSNfNa3GLlcC57Ix0_Jq80BjSVwICZO7hWHv7yWFAHij0oB7AwbfPUgjYXcKwBESYRFQKmsGzg',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://sandbox.momodeveloper.mtn.com/v1_0/apiuser'));
    request.body = '''{\r\n  "providerCallbackHost": "https://webhook.site/e4eb56d1-93a3-4be2-a01d-5ae7f43b2800"\r\n}''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }

  getUser() async{
    var headers = {
      'Ocp-Apim-Subscription-Key': '6ce2769ab2e84acfa01bfd3b7f808bb3',
      '': '',
      'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSMjU2In0.eyJjbGllbnRJZCI6ImZjNmEzNjU1LWFjYTctNDA4ZC1hNWRiLTJhYTU3MmEyYzE2ZCIsImV4cGlyZXMiOiIyMDIwLTEyLTExVDEwOjAzOjUzLjE2OSIsInNlc3Npb25JZCI6ImMyNGRlZDY0LTM4ZDctNGZhYi1hZWNmLTIyNTI1Y2JmMDljNyJ9.jsLfOhXDPvslwvqZJWiEODni7Rb4DQ7Ff4H8rJytEzF8YweaIp2Dy46SqDJnRohWhJd8JHxLw_tOyoU-hFeEo_MEz5JQJXcxZO4gsexCA6JZgqxDLb3nUwGwY8NJ6Of74pA9hsmaBxnWH8m8v_CctraAWCOEdMC2Yq9hLtW7tlyYJdjzfDc-HUfle_HLNZb91Lmq4tyqZXVh6l_1w0fgmRdfZb16OBublONtlRL9ecch-bhGyJlLHWHUYhC4f5p-lHb4rL1bIw-PKSNfNa3GLlcC57Ix0_Jq80BjSVwICZO7hWHv7yWFAHij0oB7AwbfPUgjYXcKwBESYRFQKmsGzg'
    };
    var request = http.Request('GET', Uri.parse('https://sandbox.momodeveloper.mtn.com/v1_0/apiuser/fc6a3655-aca7-408d-a5db-2aa572a2c16d'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }

  }

  getAPIKey() async{
    var headers = {
      'Ocp-Apim-Subscription-Key': '6ce2769ab2e84acfa01bfd3b7f808bb3',
      'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSMjU2In0.eyJjbGllbnRJZCI6ImZjNmEzNjU1LWFjYTctNDA4ZC1hNWRiLTJhYTU3MmEyYzE2ZCIsImV4cGlyZXMiOiIyMDIwLTEyLTExVDEwOjAzOjUzLjE2OSIsInNlc3Npb25JZCI6ImMyNGRlZDY0LTM4ZDctNGZhYi1hZWNmLTIyNTI1Y2JmMDljNyJ9.jsLfOhXDPvslwvqZJWiEODni7Rb4DQ7Ff4H8rJytEzF8YweaIp2Dy46SqDJnRohWhJd8JHxLw_tOyoU-hFeEo_MEz5JQJXcxZO4gsexCA6JZgqxDLb3nUwGwY8NJ6Of74pA9hsmaBxnWH8m8v_CctraAWCOEdMC2Yq9hLtW7tlyYJdjzfDc-HUfle_HLNZb91Lmq4tyqZXVh6l_1w0fgmRdfZb16OBublONtlRL9ecch-bhGyJlLHWHUYhC4f5p-lHb4rL1bIw-PKSNfNa3GLlcC57Ix0_Jq80BjSVwICZO7hWHv7yWFAHij0oB7AwbfPUgjYXcKwBESYRFQKmsGzg'
    };
    var request = http.Request('POST', Uri.parse('https://sandbox.momodeveloper.mtn.com/v1_0/apiuser/fc6a3655-aca7-408d-a5db-2aa572a2c16d/apikey?='));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }


  requestToPay() async{
    var headers = {
      'X-Reference-Id': '30544527-62e9-4c7a-a8cf-dd690d3ac852',
      'X-Target-Environment': 'sandbox',
      'Ocp-Apim-Subscription-Key': '6ce2769ab2e84acfa01bfd3b7f808bb3',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSMjU2In0.eyJjbGllbnRJZCI6ImZjNmEzNjU1LWFjYTctNDA4ZC1hNWRiLTJhYTU3MmEyYzE2ZCIsImV4cGlyZXMiOiIyMDIwLTEyLTExVDEwOjAzOjUzLjE2OSIsInNlc3Npb25JZCI6ImMyNGRlZDY0LTM4ZDctNGZhYi1hZWNmLTIyNTI1Y2JmMDljNyJ9.jsLfOhXDPvslwvqZJWiEODni7Rb4DQ7Ff4H8rJytEzF8YweaIp2Dy46SqDJnRohWhJd8JHxLw_tOyoU-hFeEo_MEz5JQJXcxZO4gsexCA6JZgqxDLb3nUwGwY8NJ6Of74pA9hsmaBxnWH8m8v_CctraAWCOEdMC2Yq9hLtW7tlyYJdjzfDc-HUfle_HLNZb91Lmq4tyqZXVh6l_1w0fgmRdfZb16OBublONtlRL9ecch-bhGyJlLHWHUYhC4f5p-lHb4rL1bIw-PKSNfNa3GLlcC57Ix0_Jq80BjSVwICZO7hWHv7yWFAHij0oB7AwbfPUgjYXcKwBESYRFQKmsGzg'
    };
    var request = http.Request('POST', Uri.parse('https://sandbox.momodeveloper.mtn.com/collection/v1_0/requesttopay'));
    request.body = '''{\r\n  "amount": "5.00",\r\n  "currency": "EUR",\r\n  "externalId": "rrf",\r\n  "payer": {\r\n    "partyIdType": "MSISDN",\r\n    "partyId": "0559582518"\r\n  },\r\n  "payerMessage": "momo api test",\r\n  "payeeNote": "pay note"\r\n}''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }

  }


  getStatusOfToPay() async{
    var headers = {
      'X-Reference-Id': 'fc6a3655-aca7-408d-a5db-2aa572a2c16d',
      'Ocp-Apim-Subscription-Key': '6ce2769ab2e84acfa01bfd3b7f808bb3',
      'X-Target-Environment': 'sandbox',
      'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSMjU2In0.eyJjbGllbnRJZCI6ImZjNmEzNjU1LWFjYTctNDA4ZC1hNWRiLTJhYTU3MmEyYzE2ZCIsImV4cGlyZXMiOiIyMDIwLTEyLTExVDEwOjAzOjUzLjE2OSIsInNlc3Npb25JZCI6ImMyNGRlZDY0LTM4ZDctNGZhYi1hZWNmLTIyNTI1Y2JmMDljNyJ9.jsLfOhXDPvslwvqZJWiEODni7Rb4DQ7Ff4H8rJytEzF8YweaIp2Dy46SqDJnRohWhJd8JHxLw_tOyoU-hFeEo_MEz5JQJXcxZO4gsexCA6JZgqxDLb3nUwGwY8NJ6Of74pA9hsmaBxnWH8m8v_CctraAWCOEdMC2Yq9hLtW7tlyYJdjzfDc-HUfle_HLNZb91Lmq4tyqZXVh6l_1w0fgmRdfZb16OBublONtlRL9ecch-bhGyJlLHWHUYhC4f5p-lHb4rL1bIw-PKSNfNa3GLlcC57Ix0_Jq80BjSVwICZO7hWHv7yWFAHij0oB7AwbfPUgjYXcKwBESYRFQKmsGzg'
    };
    var request = http.Request('GET', Uri.parse('https://sandbox.momodeveloper.mtn.com/collection/v1_0/requesttopay/fc6a3655-aca7-408d-a5db-2aa572a2c16d'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }

  }


  getAccountBalance() async{
    var headers = {
      'X-Target-Environment': 'sandbox',
      'Ocp-Apim-Subscription-Key': '6ce2769ab2e84acfa01bfd3b7f808bb3',
      'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSMjU2In0.eyJjbGllbnRJZCI6ImZjNmEzNjU1LWFjYTctNDA4ZC1hNWRiLTJhYTU3MmEyYzE2ZCIsImV4cGlyZXMiOiIyMDIwLTEyLTExVDEwOjAzOjUzLjE2OSIsInNlc3Npb25JZCI6ImMyNGRlZDY0LTM4ZDctNGZhYi1hZWNmLTIyNTI1Y2JmMDljNyJ9.jsLfOhXDPvslwvqZJWiEODni7Rb4DQ7Ff4H8rJytEzF8YweaIp2Dy46SqDJnRohWhJd8JHxLw_tOyoU-hFeEo_MEz5JQJXcxZO4gsexCA6JZgqxDLb3nUwGwY8NJ6Of74pA9hsmaBxnWH8m8v_CctraAWCOEdMC2Yq9hLtW7tlyYJdjzfDc-HUfle_HLNZb91Lmq4tyqZXVh6l_1w0fgmRdfZb16OBublONtlRL9ecch-bhGyJlLHWHUYhC4f5p-lHb4rL1bIw-PKSNfNa3GLlcC57Ix0_Jq80BjSVwICZO7hWHv7yWFAHij0oB7AwbfPUgjYXcKwBESYRFQKmsGzg'
    };
    var request = http.Request('GET', Uri.parse('https://sandbox.momodeveloper.mtn.com/collection/v1_0/account/balance'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }



}


