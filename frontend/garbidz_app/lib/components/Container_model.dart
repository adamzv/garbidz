import 'dart:convert';

Container containerFromJson(String str) => Container.fromJson(json.decode(str));

String containerToJson(Container data) => json.encode(data.toJson());

class Container {
  final String type;
  final String user_email;

  Container({this.type, this.user_email});

  Map<String, dynamic> toJson() =>{

    'type': type,
    'user_email': user_email,
  };


  factory Container.fromJson(Map<String, dynamic> json) => Container(

    type: json["type"],
    user_email: json["user_email"],

  );


  factory Container.fromMap(Map<String, dynamic> json)=>
      new Container (
        type: json["type"],
        user_email: json["user_email"],

      );
}
