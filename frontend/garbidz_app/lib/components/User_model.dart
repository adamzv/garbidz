import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final int id;
  final String first_name;
  final String last_name;
  final String email;
  final String token;
  final String time;

  User({this.id,this.first_name, this.last_name, this.email, this.token, this.time});

  Map<String, dynamic> toJson() =>{
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'token': token,
      'time': time,
    };


  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      first_name: json["name"],
      last_name: json["surname"],
      email: json["email"],
      token: json["token"]["token"],
      time: null,
    );


  factory User.fromMap(Map<String, dynamic> json)=>
      new User (
        id: json["id"],
        first_name: json["first_name"],
        last_name: json["last_name"],
        email: json["email"],
        token: json["token"],
        time: null,
      );
}
