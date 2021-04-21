import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final String first_name;
  final String last_name;
  final String email;
  final String token;

  User({this.first_name, this.last_name, this.email, this.token});

  Map<String, dynamic> toJson() =>{

      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'token': token,
    };


  factory User.fromJson(Map<String, dynamic> json) => User(

      first_name: json["name"],
      last_name: json["surname"],
      email: json["email"],
      token: json["token"]["token"],
    );


  factory User.fromMap(Map<String, dynamic> json)=>
      new User (
        first_name: json["name"],
        last_name: json["surname"],
        email: json["email"],
        token: json["token"],

      );
}
