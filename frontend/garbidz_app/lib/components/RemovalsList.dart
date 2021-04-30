import 'dart:convert';
import 'package:garbidz_app/components/globals.dart' as globals;
import 'package:http/http.dart' as http;

class RemovalsList {
  String garbageType;
  String date;

  RemovalsList({this.garbageType, this.date});

  static RemovalsList fromJson(Map<String, dynamic> parsedJson) => RemovalsList(
      garbageType: parsedJson['container']['garbageType'],
      date: parsedJson['schedule']['datetime']);
}

class RemovalsApi {
  static Future<List<RemovalsList>> getRemovalsList(
      String id, String token) async {
    final url = Uri.parse(
        'http://' + globals.uri + '/api/schedules/user/' + id.toString());
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token,
    });
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final List address = decoded['content'];

      return address.map((json) => RemovalsList.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }
}
