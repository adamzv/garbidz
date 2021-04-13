import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import "package:latlong/latlong.dart";
import "package:garbidz_app/components/MarkPoint.dart";
import "package:garbidz_app/components/widgets/MarkDetail.dart";


class MapContainers extends StatefulWidget {
  @override
  _MapContainersState createState() => _MapContainersState();


}

class _MapContainersState extends State<MapContainers> {
  List<MarkPoint> markers = [
    MarkPoint(address: '7. pešieho pluku, Nitra', lng: 48.307027, lnt: 18.085075, containers: [{'type':'Papier a lepenka'},{'id':'1', 'type':'Plast'},{'type':'Zmesový komunálny odpad'}]),
    MarkPoint(address: 'Palánok, Nitra', lng: 48.311383, lnt: 18.082601, containers: [{'type':'Papier a lepenka'},{'id':'1', 'type':'Plast'}]),
    MarkPoint(address: 'Hlboká 63, Nové Zámky', lng: 48.294796, lnt: 18.072434, containers: [{'type':'Papier a lepenka'}]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapy kontajnerov'),
      ),
      body: Center(
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(48.30763, 18.08453),
            zoom: 13.0
          ),
          layers: [
            new TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
            new MarkerLayerOptions(
              markers: markers.map((marker) => Marker(
                  width: 40.0,
                  height: 40.0,
                  point: new LatLng(marker.lng, marker.lnt),
                  builder: (ctx) =>
                  new Container(
                    child: IconButton(
                      onPressed: (){
                        showModalBottomSheet(
                            context: context,
                            builder: (builder){ return MarkDetail(address: marker.address, containers: marker.containers); }
                        );
                      },
                      color: Colors.pink,
                      iconSize: 40.0,
                      icon: Icon(
                          Icons.location_pin,
                      color: Colors.pink),
                    ),
                  ),
                )).toList(),

            ),

            ],
    )
      )
    );
  }
}
