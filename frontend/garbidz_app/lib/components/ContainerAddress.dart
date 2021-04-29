import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:garbidz_app/components/globals.dart' as globals;
class ContainerAddress{
  int id;
  String name;

  ContainerAddress({this.id, this.name});

  static ContainerAddress fromJson(Map<String, dynamic> parsedJson) => ContainerAddress(id: parsedJson['id'], name: parsedJson['address']+", "+ parsedJson['town']['town']);
}

class AddressApi {
  static String token = "";
  static Future<List<ContainerAddress>> getAddressSuggestions(String query) async {
    final url = Uri.parse('http://'+globals.uri+'/api/addresses?size=2000');
    final response = await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer '+token,
        });
    if(response.statusCode == 200){
      final decoded = jsonDecode(response.body);
      final List address = decoded['content'];

      return address.map((json) => ContainerAddress.fromJson(json)).toList();
    }else{
      throw Exception();
    }

  }
}
