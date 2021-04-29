import 'dart:convert';

import 'package:garbidz_app/components/address_model.dart';
import 'package:garbidz_app/components/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

class HttpService{
  final String postsUrl = "http://"+globals.uri+"/api/addresses?size=2000";
  Future <List<Address>> getPosts()async{
    final res = await http.get(
        Uri.parse(postsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqdXIudmFua29AZ21haWwuY29tIiwiZXhwIjoxNjUxMTA2MzU5fQ.0N2xg5-q0L-w_G1kzZkNVaXDnxlbcF9dDNTrjLR1sCs',
        });

    if(res.statusCode == 200){
      try{
        final decoded = jsonDecode(res.body);
        List<dynamic> body = decoded['content'];

        List<Address> addresses = body.map((dynamic item) => Address.fromJson(item)).toList();
        return addresses;
      }catch(e){
        print(e);
      }
    }
    else{
      throw "Can't get posts.";
    }
  }
}