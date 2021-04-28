import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:garbidz_app/components/RemovalsList.dart';
import 'package:intl/intl.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
class Removals extends StatefulWidget {
  @override
  _RemovalsState createState() => _RemovalsState();
}

class _RemovalsState extends State<Removals> {
  AutoScrollController controller;

  Color getColorOfContainer(String type){
    Color color ;
    if(type=="zmesový komunálny odpad"){
      color = Color.fromRGBO(0, 0, 0, 1);
    }
    else if(type == "plasty"){
      color = Color.fromRGBO(241, 196, 15, 1.0);
    }
    else if(type == "papier a lepenka"){
      color = Color.fromRGBO(52, 152, 219, 1.0);
    }
    else if(type == "bioodpad"){
      color = Color.fromRGBO(159, 97, 106, 1.0);
    }
    return color;
  }

  String getNameOfContainer(String type){
    String name ;
    if(type=="zmesový komunálny odpad"){
      name = "Komunálny odpad";
    }
    else if(type == "plasty"){
      name = "Plasty";
    }
    else if(type == "papier a lepenka"){
      name = "Papier";
    }
    else if(type == "bioodpad"){
      name = "Bioodpad";
    }
    return name;
  }

  String changeDateFormat(String date, int type){
    String dateTime;
    if(type==1)
      dateTime = DateFormat('d.M.y').format(DateTime.parse(date));
    if(type==2)
      dateTime = DateFormat('d.M.y H:m').format(DateTime.parse(date));
    return dateTime;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(63, 29, 90, 1.0),
      body: SafeArea(
        child: ListView(
            shrinkWrap: true,
          children: [
            FutureBuilder(
            future: RemovalsApi.getRemovalsList(1),
            builder: (BuildContext context, AsyncSnapshot<List<RemovalsList>> snapshot){
            if(snapshot.hasData){
             List<RemovalsList> rem = snapshot.data;
             return Padding(
               padding: const EdgeInsets.fromLTRB(20.0,46.0,20.0,46.0),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   Center(
                     child: Text(
                       "Odvozy odpadu",
                       textAlign: TextAlign.center,
                       style: TextStyle(
                           fontFamily: "Poppins",
                           color: Colors.white,
                           fontWeight: FontWeight.w600,
                           fontSize: 30.0
                       ),
                     ),
                   ),
                   SizedBox(height: 30.0),
                   SingleChildScrollView(
                     child: ListView(
                       controller: controller,
                       shrinkWrap: true,
                       children: rem.map((removal) => Column(
                         children: [
                           Container(
                             padding: EdgeInsets.all(20.0),
                             decoration:new BoxDecoration(
                               boxShadow: [BoxShadow(
                                 color: Color.fromRGBO(63, 29, 90, 0.5),
                                 spreadRadius: 5,
                                 blurRadius: 7,
                                 offset: Offset(0, 3), // changes position of shadow
                               ),],
                               color: Colors.white,
                               borderRadius: BorderRadius.all(Radius.circular(8.0)),
                             ),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(
                                   changeDateFormat(removal.date, 1),
                                   textAlign: TextAlign.end,
                                   style: TextStyle(
                                     fontFamily: "Poppins",
                                     fontSize: 17.0,
                                     color: Colors.grey[600],
                                   ),
                                 ),
                                 SizedBox(height: 20,),
                                 Row(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Icon(
                                       Icons.delete,
                                       size: 40,
                                       color: getColorOfContainer(removal.garbageType),
                                     ),
                                     SizedBox(width:20),
                                     Column(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(
                                           getNameOfContainer(removal.garbageType),
                                           style: TextStyle(
                                               fontFamily: "Poppins",
                                               color: Color.fromRGBO(63, 29, 90, 1.0),
                                               fontSize: 18.0
                                           ),
                                         ),
                                         Text(
                                           changeDateFormat(removal.date, 2),
                                           style: TextStyle(
                                               fontFamily: "Poppins",
                                               fontWeight: FontWeight.w600,
                                               color: Color.fromRGBO(63, 29, 90, 1.0),
                                               fontSize: 18.0
                                           ),
                                         ),
                                       ],
                                     )
                                   ],
                                 )
                               ],
                             ),
                           ),
                           SizedBox(height: 20.0,),


                         ],
                       )).toList(),
                     ),
                   ),
                 ],
               ),
             );
            }else {
            return Center(child: CircularProgressIndicator());
             }
              }
            ),
      ]
        ),
        ),
      );
  }
}
