import 'package:flutter/material.dart';

class MarkDetail extends StatelessWidget{

  String address;
  List containers;

  MarkDetail({this.address, this.containers});

  @override
  Widget build(BuildContext context) {
    List<Row> containerss = [];
    for(int i =0; i<containers.length; i++){
      if(containers[i]['type'].toString().toLowerCase().contains('papier')){
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
      }else if(containers[i]['type'].toString().toLowerCase().contains('plast')){
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
      }else if(containers[i]['type'].toString().toLowerCase().contains('komunál')){
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
      }
    }
    return Container(
      color: Color(0xFF737373), // This line set the transparent background
      child: Container(
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
                        Text('$address',
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
      ),
    );
  }

}