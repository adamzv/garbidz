import 'dart:convert';

import 'package:garbidz_app/components/address_model.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

class HttpService{
  final String postsUrl = "http://10.0.2.2:8080/api/addresses";
  Future <List<Address>> getPosts()async{
    final res = await http.get(
        Uri.parse(postsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqdXIudmFua29AZ21haWwuY29tIiwiZXhwIjoxNjE4OTY0NDc2fQ.d7rnkhAwUL-80LWW2ch_rArir7fW7CbM195yO7m34qo',
        });

    if(res.statusCode == 200){
      try{
        final decoded = jsonDecode(res.body);
        print(decoded['content']);
        List<dynamic> body = decoded['content'];

        List<Address> addresses = body.map((dynamic item) => Address.fromJson(item)).toList();
        print(addresses.length.toString());
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