import 'dart:convert';
import 'package:http/http.dart' as http;
class RemovalsList{
  String garbageType;
  String date;

  RemovalsList({this.garbageType, this.date});

  static RemovalsList fromJson(Map<String, dynamic> parsedJson) => RemovalsList(garbageType: parsedJson['container']['garbageType'], date: parsedJson['schedule']['datetime']);
}

class RemovalsApi{
  static Future<List<RemovalsList>> getRemovalsList(int id) async {
  final url = Uri.parse('http://10.0.2.2:8080/api/schedules/user/'+id.toString());
  final response = await http.get(url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqdXIudmFua29AZ21haWwuY29tIiwiZXhwIjoxNjUxMTA2MzU5fQ.0N2xg5-q0L-w_G1kzZkNVaXDnxlbcF9dDNTrjLR1sCs',
      });
  if(response.statusCode == 200){
    final decoded = jsonDecode(response.body);
    final List address = decoded['content'];

    return address.map((json) => RemovalsList.fromJson(json)).toList();
  }else{
    throw Exception();
  }

  }
  }
