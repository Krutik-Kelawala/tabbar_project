import 'package:flutter/material.dart';

class Stackwidget extends StatefulWidget {
  @override
  State<Stackwidget> createState() => _StackwidgetState();
}

class _StackwidgetState extends State<Stackwidget> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Profile"),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: height * 0.3,
                ),
                Container(
                  height: height * 0.6,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(100),
                          topLeft: Radius.circular(100))),
                ),
              ],
            ),
            Positioned(
                top: height * 0.15,
                left: width * 0.3,
                child: Container(
                  height: height * 0.3,
                  width: width * 0.4,
                  child: CircleAvatar(backgroundColor: Colors.grey),
                )),
            Positioned(
                child: SingleChildScrollView(
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(width * 0.01),
                        child: TextField(
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.all(width * 0.01),
                        child: TextField(
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.all(width * 0.01),
                        child: TextField(
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        ),
                      ),
                    )
                  ],
                )
              ]),
            ))
          ],
        ));
  }
}
