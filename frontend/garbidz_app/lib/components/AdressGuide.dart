import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class AdressGuide{
  int id;
  String name;

  AdressGuide({this.id, this.name});

  static AdressGuide fromJson(Map<String, dynamic> parsedJson) => AdressGuide(id: parsedJson['id'], name: parsedJson['name']);
}

class AddressApi{
  static Future<List<AdressGuide>> getAddressSuggestions(String query) async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
  final response = await http.get(url);
  if(response.statusCode == 200){
    final List address = jsonDecode(response.body);

    return address.map((json) => AdressGuide.fromJson(json)).where((address){
    final nameLower = address.name.toLowerCase();
    final queryLower = query.toLowerCase();

    return nameLower.contains(queryLower);
   }).toList();
  }else{
    throw Exception();
  }

  }
  }
