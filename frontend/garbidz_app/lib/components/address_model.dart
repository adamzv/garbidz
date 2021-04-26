import 'package:flutter/cupertino.dart';

class Address{
  final int id;
  final String address;
  final double lat;
  final double lon;
  final Map town;

  Address({
    @required this.id,
    @required this.address,
    @required this.lat,
    @required this.lon,
    @required this.town,
  });

  factory Address.fromJson(Map<String, dynamic> json){
    double lat = double.parse(json['lat']);
    double lon = double.parse(json['lon']);
    return Address(
        id: json['id'] as int,
        address: json['address'] as String,
        lat: lat,
        lon: lon,
        town: json['town'] as Map
    );
  }

}