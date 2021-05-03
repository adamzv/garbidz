import 'package:flutter/material.dart';
import 'package:garbidz_app/components/globals.dart' as globals;
import 'dart:convert';
import 'package:http/http.dart' as http;

class MarkDetail extends StatefulWidget{
  String id;
  String address;

  MarkDetail({this.address, this.id});

  @override
  _MarkDetailState createState() => _MarkDetailState();
}

class _MarkDetailState extends State<MarkDetail> {
  List containers;

  Future<List> getContainers() async{
    List<Row> containerss = [];
    final url = Uri.parse('http://'+globals.uri+'/api/containers/address/'+widget.id);
    final response = await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json; charset=UTF-8'
        });
    if(response.statusCode == 200) {
      final List decoded = jsonDecode(response.body);

      for(int i =0; i<decoded.length; i++){
        print(decoded[i]['garbageType'].toString().toLowerCase());
        if(decoded[i]['garbageType'].toString().toLowerCase().contains('papier')){
          Row container = Row(
            children: [
              Icon(
                Icons.delete,
                color: Color.fromRGBO(52, 152, 219, 1.0),
                size: 25.0 ,
              ),
              Text('Papier',
                style: TextStyle(
                    color: Color.fromRGBO(63 , 29, 90, 1.0),
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          );
          containerss.add(container);
        }else if(decoded[i]['garbageType'].toString().toLowerCase().contains('plast')){
          Row container = Row(
            children: [
              Icon(
                Icons.delete,
                color: Color.fromRGBO(241, 196, 15, 1.0),
                size: 25.0 ,
              ),
              Text('Plast',
                style: TextStyle(
                    color: Color.fromRGBO(63 , 29, 90, 1.0),
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          );
          containerss.add(container);
        }else if(decoded[i]['garbageType'].toString().toLowerCase().contains('komunál')){
          Row container = Row(
            children: [
              Icon(
                Icons.delete,
                color: Color.fromRGBO(0, 0, 0, 1.0),
                size: 25.0 ,
              ),
              Text('Komunálny odpad',
                style: TextStyle(
                    color: Color.fromRGBO(63 , 29, 90, 1.0),
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          );
          containerss.add(container);
        }else if(decoded[i]['garbageType'].toString().toLowerCase().contains('sklo')){
          Row container = Row(
            children: [
              Icon(
                Icons.delete,
                color: Color.fromRGBO(44, 204, 31, 1.0),
                size: 25.0 ,
              ),
              Text('Sklo',
                style: TextStyle(
                    color: Color.fromRGBO(63 , 29, 90, 1.0),
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          );
          containerss.add(container);
        }else if(decoded[i]['garbageType'].toString().toLowerCase().contains('zmiešané')){
          Row container = Row(
            children: [
              Icon(
                Icons.delete,
                color: Color.fromRGBO(252, 121, 0, 1.0),
                size: 25.0 ,
              ),
              Text('Zmiešané obaly',
                style: TextStyle(
                    color: Color.fromRGBO(63 , 29, 90, 1.0),
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          );
          containerss.add(container);
        }
      }
      print(response.body);
    }else{
      print(response.body);
    }
    return containerss;
    }

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    getContainers();
    print(widget.id);
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Color(0xFF737373), // This line set the transparent background
      child: FutureBuilder(
        future: getContainers(),
    builder: (BuildContext context, AsyncSnapshot<List> snapshot){
    if(snapshot.hasData){
    List containerss = snapshot.data;
    return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28.0),
                    topRight: Radius.circular(28.0)
                )
            ),
            child: Padding(
              padding: EdgeInsets.all(34.0),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text('Zvolené miesto',
                      style: TextStyle(
                        color: Color.fromRGBO(173, 173, 173, 1.0),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 14.0,0.0,20.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Color.fromRGBO(189, 18, 121, 1.0),
                            size: 25.0 ,
                          ),
                          Text('${widget.address}',
                            style: TextStyle(
                                color: Color.fromRGBO(189, 18, 121, 1.0),
                                fontFamily: 'Poppins',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    child: Text('Typy kontajnerov',
                      style: TextStyle(
                        color: Color.fromRGBO(173, 173, 173, 1.0),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  SizedBox(height: 14.0),
                  Column(
                    children: containerss,
                  )
                ],
              ),
            )
        );}else{
      return CircularProgressIndicator();
    }}
      ),
    );
  }
}