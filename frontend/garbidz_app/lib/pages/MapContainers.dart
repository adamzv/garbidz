import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:garbidz_app/components/address_model.dart';
import 'package:garbidz_app/components/http_service.dart';
import "package:latlong/latlong.dart";
import "package:garbidz_app/components/MarkPoint.dart";
import "package:garbidz_app/components/widgets/MarkDetail.dart";
import "package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart";
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';


class MapContainers extends StatefulWidget {
  @override
  _MapContainersState createState() => _MapContainersState();


}

class _MapContainersState extends State<MapContainers> {
  final HttpService httpService = HttpService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(63, 29, 90, 1.0),
      body: SafeArea(
        child: FutureBuilder(
          future: httpService.getPosts(),
          builder: (BuildContext context, AsyncSnapshot<List<Address>> snapshot){
            if(snapshot.hasData){
              List<Address> addresses = snapshot.data;
            return FlutterMap(
              options: MapOptions(
                  center: LatLng(48.30763, 18.08453),
                  zoom: 14.0,
                  plugins: [MarkerClusterPlugin(),]
              ),
              layers: [
                new TileLayerOptions(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                new MarkerClusterLayerOptions(
                  maxClusterRadius: 120,
                  size: Size(40, 40),
                  fitBoundsOptions: FitBoundsOptions(
                    padding: EdgeInsets.all(50),
                  ),
                  markers: addresses.map((address) => Marker(
                    width: 30.0,
                    height: 30.0,
                    point: new LatLng(address.lat, address.lon),
                    builder: (ctx) =>
                    new Container(
                      child: IconButton(
                        onPressed: (){
                          showModalBottomSheet(
                              context: context,
                              builder: (builder){ return MarkDetail(address: address.address+", "+address.town['town'], id: address.id.toString(),); }
                          );
                        },
                        color: Colors.pink,
                        iconSize: 30.0,
                        icon: Icon(
                            Icons.location_pin,
                            color: Colors.pink),
                      ),
                    ),
                  )).toList(),
                  polygonOptions: PolygonOptions(
                     borderColor: Colors.pink,
                       color: Colors.black12,
                        borderStrokeWidth: 3),
                        builder: (context, markers) {
                        return FloatingActionButton(
                          child: Text(markers.length.toString()),
                          backgroundColor: Colors.pink,
                          onPressed: null,
                        );
                        },
                ),
              ],
            );
            }else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      )
    );
  }
}
