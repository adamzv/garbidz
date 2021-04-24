import 'package:flutter/material.dart';

class Removals extends StatefulWidget {
  @override
  _RemovalsState createState() => _RemovalsState();
}

class _RemovalsState extends State<Removals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(63, 29, 90, 1.0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
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
                Column(
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
                              "20.04.2021",
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
                                  color: Colors.brown,
                                ),
                                SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Bioodpad",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: Color.fromRGBO(63, 29, 90, 1.0),
                                        fontSize: 18.0
                                      ),
                                    ),
                                    Text(
                                      "20.04.2021 o 08:00",
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
                              "20.04.2021",
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
                                  color: Colors.brown,
                                ),
                                SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Bioodpad",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: Color.fromRGBO(63, 29, 90, 1.0),
                                          fontSize: 18.0
                                      ),
                                    ),
                                    Text(
                                      "20.04.2021 o 08:00",
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
                              "20.04.2021",
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
                                  color: Colors.brown,
                                ),
                                SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Bioodpad",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: Color.fromRGBO(63, 29, 90, 1.0),
                                          fontSize: 18.0
                                      ),
                                    ),
                                    Text(
                                      "20.04.2021 o 08:00",
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
                              "20.04.2021",
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
                                  color: Colors.brown,
                                ),
                                SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Bioodpad",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: Color.fromRGBO(63, 29, 90, 1.0),
                                          fontSize: 18.0
                                      ),
                                    ),
                                    Text(
                                      "20.04.2021 o 08:00",
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
                              "20.04.2021",
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
                                  color: Colors.brown,
                                ),
                                SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Bioodpad",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: Color.fromRGBO(63, 29, 90, 1.0),
                                          fontSize: 18.0
                                      ),
                                    ),
                                    Text(
                                      "20.04.2021 o 08:00",
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
                              "20.04.2021",
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
                                  color: Colors.brown,
                                ),
                                SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Bioodpad",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: Color.fromRGBO(63, 29, 90, 1.0),
                                          fontSize: 18.0
                                      ),
                                    ),
                                    Text(
                                      "20.04.2021 o 08:00",
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
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
