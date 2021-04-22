import 'dart:convert';
import 'package:http/http.dart' as http;
class AdressGuide{
  int id;
  String name;

  AdressGuide({this.id, this.name});

  static AdressGuide fromJson(Map<String, dynamic> parsedJson) => AdressGuide(id: parsedJson['id'], name: parsedJson['address']+", "+ parsedJson['town']['town']);
}

class AddressApi{
  static Future<List<AdressGuide>> getAddressSuggestions(String query) async {
  final url = Uri.parse('http://10.0.2.2:8080/api/addresses?size=2000');
  final response = await http.get(url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqdXIudmFua29AZ21haWwuY29tIiwiZXhwIjoxNjE5MTI0Mzc0fQ.fENISxEMs6m9eNF3Bvkv9_2JG-3Aa9kRl1borZwM2MA',
      });
  if(response.statusCode == 200){
    final decoded = jsonDecode(response.body);
    final List address = decoded['content'];

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
