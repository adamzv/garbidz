import 'dart:convert';

Kontainer KontainerFromJson(String str) => Kontainer.fromJson(json.decode(str));

String KontainerToJson(Kontainer data) => json.encode(data.toJson());

class Kontainer {
  final String type;
  final String user_email;

  Kontainer({this.type, this.user_email});

  Map<String, dynamic> toJson() =>{

    'type': type,
    'user_email': user_email,
  };


  factory Kontainer.fromJson(Map<String, dynamic> json) => Kontainer(

    type: json["type"],
    user_email: json["user_email"],

  );


  factory Kontainer.fromMap(Map<String, dynamic> json)=>
      new Kontainer (
        type: json["type"],
        user_email: json["user_email"],

      );


  List<Kontainer> fromList(List<Map<String,dynamic>> query) {
    List<Kontainer> smetiak = List<Kontainer>();
    for (Map map in query) {
      smetiak.add(Kontainer.fromMap(map));
    }
    return smetiak;
  }
}
