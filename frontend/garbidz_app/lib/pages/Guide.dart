import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Guide extends StatefulWidget {
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<Guide> {
  PageController pageController = PageController(initialPage: 0);
  int pageChange = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(63, 29, 90, 1.0),
      body: Center(
        child: PageView(
          controller: pageController,
          onPageChanged: (index){
            setState(() {
              pageChange = index;
            });
            print(pageChange);
          },
          children: [
            SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                color: Color.fromRGBO(63, 29, 90, 1.0),
                child: Column(
                  children: [
                    SizedBox(height: 40.0),
                    Text(
                      "Nastavte sa",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                        fontSize: 28.0,
                        color: Colors.white
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Expanded(
                      flex: 1,
                        child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1.0),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(28.0), topRight:  Radius.circular(28.0))),
                      child: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                            Image.asset('assets/guide/01.png'),
                            SizedBox(height: 20.0),
                            Text("Dobrý deň,",
                            style: TextStyle(
                              color: Color.fromRGBO(63, 29, 90, 1.0),
                              fontWeight: FontWeight.w600,
                              fontSize: 28.0,
                              ),
                            ),
                            Text("Juraj",
                              style: TextStyle(
                                color: Color.fromRGBO(63, 29, 90, 1.0),
                                fontWeight: FontWeight.w800,
                                fontSize: 28.0,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text("Poďme na to!",
                              style: TextStyle(
                                color: Color.fromRGBO(63, 29, 90, 1.0),
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
              color: Color.fromRGBO(63, 29, 90, 1.0),
              child: Column(
                children: [
                  SizedBox(height: 40.0),
                  Text(
                    "Nastavte sa",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                        fontSize: 28.0,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1.0),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(28.0), topRight:  Radius.circular(28.0))),
                        child: Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              Image.asset('assets/guide/02.png'),
                              SizedBox(height: 20.0),
                              Text("Začnime s výberom Vašej adresy",
                                style: TextStyle(
                                  color: Color.fromRGBO(63, 29, 90, 1.0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(height: 20.0),
                              TextField(
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Zadajte adresu',
                                    prefixIcon: Icon(Icons.search),
                                    hintText: 'Adresa...'),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ),
            ),
            SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                color: Color.fromRGBO(63, 29, 90, 1.0),
                child: Column(
                  children: [
                    SizedBox(height: 40.0),
                    Text(
                      "Nastavte sa",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                          fontSize: 28.0,
                          color: Colors.white
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1.0),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(28.0), topRight:  Radius.circular(28.0))),
                          child: Padding(
                            padding: EdgeInsets.all(30.0),
                            child: Column(
                              children: [
                                Image.asset('assets/guide/01.png'),
                                SizedBox(height: 20.0),
                                Text("Dobrý deň,",
                                  style: TextStyle(
                                    color: Color.fromRGBO(63, 29, 90, 1.0),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 28.0,
                                  ),
                                ),
                                Text("Juraj",
                                  style: TextStyle(
                                    color: Color.fromRGBO(63, 29, 90, 1.0),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 28.0,
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                Text("Poďme na to!",
                                  style: TextStyle(
                                    color: Color.fromRGBO(63, 29, 90, 1.0),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
              color: Color.fromRGBO(63, 29, 90, 1.0),
              child: Column(
                children: [
                  SizedBox(height: 40.0),
                  Text(
                    "Nastavte sa",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                        fontSize: 28.0,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1.0),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(28.0), topRight:  Radius.circular(28.0))),
                        child: Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              Image.asset('assets/guide/01.png'),
                              SizedBox(height: 20.0),
                              Text("Dobrý deň,",
                                style: TextStyle(
                                  color: Color.fromRGBO(63, 29, 90, 1.0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 28.0,
                                ),
                              ),
                              Text("Juraj",
                                style: TextStyle(
                                  color: Color.fromRGBO(63, 29, 90, 1.0),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 28.0,
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Text("Poďme na to!",
                                style: TextStyle(
                                  color: Color.fromRGBO(63, 29, 90, 1.0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ),
            )
          ],
        ),
      ),
    );
  }
}
