import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:garbidz_app/components/globals.dart' as globals;
class AdressGuide{
  int id;
  String name;

  AdressGuide({this.id, this.name});

  static AdressGuide fromJson(Map<String, dynamic> parsedJson) => AdressGuide(id: parsedJson['id'], name: parsedJson['address']+", "+ parsedJson['town']['town']);
}

class AddressApi {
  static String token = "";
  static Future<List<AdressGuide>> getAddressSuggestions(String query) async {
  final url = Uri.parse('http://'+globals.uri+'/api/addresses/all');
  final response = await http.get(url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+token,
      });
  if(response.statusCode == 200){
    final decoded = jsonDecode(response.body);
    final List address = decoded;

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
