import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tabbar_project/main.dart';

class Futurebuildpage extends StatefulWidget {
  @override
  State<Futurebuildpage> createState() => _FuturebuildpageState();
}

class _FuturebuildpageState extends State<Futurebuildpage> {
  List<My_Dataclass> viewlist = [];
  String imggg = "";
  bool loadscreenn = false;

  @override
  void initState() {
    super.initState();
    getmyalldata();
  }

  getmyalldata() async {
    var url = Uri.parse('https://api.instantwebtools.net/v1/airlines');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      List myviewdata = jsonDecode(response.body);

      for (int i = 0; i < myviewdata.length; i++) {
        My_Dataclass vv = My_Dataclass.fromJson(myviewdata[i]);
        setState(() {
          viewlist.add(vv);
          loadscreenn = true;
        });
      }
      print("Data=== ${response.body.toString()}");

    } else {
      print("Something Wrong went");
      Text("Something Wrong..");
      throw Exception('Failed to load post');
    }
  }

  /* Future<List<My_Dataclass>> getmyalldata() async {
    var url = Uri.parse('https://api.instantwebtools.net/v1/airlines');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      List myviewdata = jsonDecode(response.body);

      for (int i = 0; i < myviewdata.length; i++) {
        My_Dataclass vv = My_Dataclass.fromJson(myviewdata[i]);
        viewlist.add(vv);
      }
      return viewlist;
    } else {
      print("Something Wrong went");
      throw Exception('Failed to load post');
    }
  }*/

  @override
  Widget build(BuildContext context) {
    double theheight = MediaQuery.of(context).size.height;
    double thewidth = MediaQuery.of(context).size.width;
    double thestatusbarheight = MediaQuery.of(context).padding.top;
    double thenavigatorbarheight = MediaQuery.of(context).padding.bottom;
    double theappbarheight = kToolbarHeight;
    double the_Bodyheight = theheight -
        thestatusbarheight -
        theappbarheight -
        thenavigatorbarheight;

    return WillPopScope(
      onWillPop: mainpagee,
      child: Scaffold(
          backgroundColor: Color(0xFFB0E1DE),
          appBar: AppBar(
            title: Text(
              "Future Builder",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: loadscreenn
              ? ListView.builder(
                  itemCount: viewlist.length,
                  itemBuilder: (context, index) {
                    print("Length === ${viewlist.length}");
                    return Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFD6E2C1),
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(the_Bodyheight * 0.02),
                      margin: EdgeInsets.all(the_Bodyheight * 0.01),
                      child: Column(children: [
                        Container(
                          child: imggg == ""
                              ? Container(
                                  height: the_Bodyheight * 0.3,
                                  width: thewidth * 0.6,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "${viewlist[index].logo}"),
                                          fit: BoxFit.contain)),
                                )
                              : Container(
                                  child: Icon(Icons.camera_alt_outlined),
                                ),
                        ),
                        SizedBox(
                          height: the_Bodyheight * 0.03,
                        ),
                        Row(
                          children: [
                            Text(
                              "ID : ",
                              style: TextStyle(
                                  fontSize: the_Bodyheight * 0.02,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "${viewlist[index].id}",
                              style: TextStyle(
                                  fontSize: the_Bodyheight * 0.02,
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Name : ",
                              style: TextStyle(
                                  fontSize: the_Bodyheight * 0.02,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "${viewlist[index].name}",
                              style: TextStyle(
                                fontSize: the_Bodyheight * 0.02,
                                // fontWeight: FontWeight.w300
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Country : ",
                              style: TextStyle(
                                  fontSize: the_Bodyheight * 0.02,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "${viewlist[index].country}",
                              style: TextStyle(
                                fontSize: the_Bodyheight * 0.02,
                                // fontWeight: FontWeight.w300
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Slogan : ",
                              style: TextStyle(
                                  fontSize: the_Bodyheight * 0.02,
                                  fontWeight: FontWeight.w300),
                            ),
                            Expanded(
                              child: Text(
                                "${viewlist[index].slogan}",
                                style: TextStyle(
                                  fontSize: the_Bodyheight * 0.02,
                                  // fontWeight: FontWeight.w300
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Head_Quaters : ",
                              style: TextStyle(
                                  fontSize: the_Bodyheight * 0.02,
                                  fontWeight: FontWeight.w300),
                            ),
                            Expanded(
                              child: Text(
                                "${viewlist[index].headQuaters}",
                                style: TextStyle(
                                  fontSize: the_Bodyheight * 0.02,
                                  // fontWeight: FontWeight.w300
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Website : ",
                              style: TextStyle(
                                  fontSize: the_Bodyheight * 0.02,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "${viewlist[index].website}",
                              style: TextStyle(
                                  fontSize: the_Bodyheight * 0.02,
                                  color: Colors.blue
                                  // fontWeight: FontWeight.w300
                                  ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Established : ",
                              style: TextStyle(
                                  fontSize: the_Bodyheight * 0.02,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "${viewlist[index].established}",
                              style: TextStyle(
                                  fontSize: the_Bodyheight * 0.02,
                                  color: Colors.red
                                  // fontWeight: FontWeight.w300
                                  ),
                            )
                          ],
                        )
                      ]),
                    );
                  },
                )
              : Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Please wait...   ",
                        style: TextStyle(fontSize: the_Bodyheight * 0.04),
                      ),
                      SizedBox(
                        height: the_Bodyheight * 0.05,
                      ),
                      CircularProgressIndicator(
                        backgroundColor: Colors.yellowAccent,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.orange),
                      ),
                    ],
                  ),
                )
          // FutureBuilder(
          //   future: getmyalldata(),
          //   builder: (context, snapshot) {
          //     // if (snapshot.hasData) {
          //     //   return ListView.builder(
          //     //     itemCount: snapshot.data,
          //     //     itemBuilder: (context, index) {
          //     //       return Container(
          //     //         decoration: BoxDecoration(border: Border.all(width: 1)),
          //     //         padding: EdgeInsets.all(the_Bodyheight * 0.02),
          //     //         margin: EdgeInsets.all(the_Bodyheight * 0.01),
          //     //         child: Column(children: [
          //     //           Container(
          //     //             height: the_Bodyheight * 0.4,
          //     //             width: thewidth * 0.5,
          //     //             decoration: BoxDecoration(
          //     //                 image: DecorationImage(
          //     //                     image: NetworkImage("${viewlist[index].logo}"),
          //     //                     fit: BoxFit.contain)),
          //     //           ),
          //     //           SizedBox(
          //     //             height: the_Bodyheight * 0.03,
          //     //           ),
          //     //           Row(
          //     //             children: [
          //     //               Text(
          //     //                 "ID : ",
          //     //                 style: TextStyle(
          //     //                     fontSize: the_Bodyheight * 0.02,
          //     //                     fontWeight: FontWeight.w300),
          //     //               ),
          //     //               Text(
          //     //                 "${viewlist[index].id}",
          //     //                 style: TextStyle(
          //     //                     fontSize: the_Bodyheight * 0.02,
          //     //                     fontWeight: FontWeight.w300),
          //     //               )
          //     //             ],
          //     //           ),
          //     //           Row(
          //     //             children: [
          //     //               Text(
          //     //                 "Name : ",
          //     //                 style: TextStyle(
          //     //                     fontSize: the_Bodyheight * 0.02,
          //     //                     fontWeight: FontWeight.w300),
          //     //               ),
          //     //               Text(
          //     //                 "${viewlist[index].name}",
          //     //                 style: TextStyle(
          //     //                   fontSize: the_Bodyheight * 0.02,
          //     //                   // fontWeight: FontWeight.w300
          //     //                 ),
          //     //               )
          //     //             ],
          //     //           ),
          //     //           Row(
          //     //             children: [
          //     //               Text(
          //     //                 "Country : ",
          //     //                 style: TextStyle(
          //     //                     fontSize: the_Bodyheight * 0.02,
          //     //                     fontWeight: FontWeight.w300),
          //     //               ),
          //     //               Text(
          //     //                 "${viewlist[index].country}",
          //     //                 style: TextStyle(
          //     //                   fontSize: the_Bodyheight * 0.02,
          //     //                   // fontWeight: FontWeight.w300
          //     //                 ),
          //     //               )
          //     //             ],
          //     //           ),
          //     //           Row(
          //     //             children: [
          //     //               Text(
          //     //                 "Slogan : ",
          //     //                 style: TextStyle(
          //     //                     fontSize: the_Bodyheight * 0.02,
          //     //                     fontWeight: FontWeight.w300),
          //     //               ),
          //     //               Expanded(
          //     //                 child: Text(
          //     //                   "${viewlist[index].slogan}",
          //     //                   style: TextStyle(
          //     //                     fontSize: the_Bodyheight * 0.02,
          //     //                     // fontWeight: FontWeight.w300
          //     //                   ),
          //     //                 ),
          //     //               )
          //     //             ],
          //     //           ),
          //     //           Row(
          //     //             children: [
          //     //               Text(
          //     //                 "Head_Quaters : ",
          //     //                 style: TextStyle(
          //     //                     fontSize: the_Bodyheight * 0.02,
          //     //                     fontWeight: FontWeight.w300),
          //     //               ),
          //     //               Expanded(
          //     //                 child: Text(
          //     //                   "${viewlist[index].headQuaters}",
          //     //                   style: TextStyle(
          //     //                     fontSize: the_Bodyheight * 0.02,
          //     //                     // fontWeight: FontWeight.w300
          //     //                   ),
          //     //                 ),
          //     //               )
          //     //             ],
          //     //           ),
          //     //           Row(
          //     //             children: [
          //     //               Text(
          //     //                 "Website : ",
          //     //                 style: TextStyle(
          //     //                     fontSize: the_Bodyheight * 0.02,
          //     //                     fontWeight: FontWeight.w300),
          //     //               ),
          //     //               Text(
          //     //                 "${viewlist[index].website}",
          //     //                 style: TextStyle(
          //     //                     fontSize: the_Bodyheight * 0.02,
          //     //                     color: Colors.blue
          //     //                     // fontWeight: FontWeight.w300
          //     //                     ),
          //     //               )
          //     //             ],
          //     //           ),
          //     //           Row(
          //     //             children: [
          //     //               Text(
          //     //                 "Established : ",
          //     //                 style: TextStyle(
          //     //                     fontSize: the_Bodyheight * 0.02,
          //     //                     fontWeight: FontWeight.w300),
          //     //               ),
          //     //               Text(
          //     //                 "${viewlist[index].established}",
          //     //                 style: TextStyle(
          //     //                     fontSize: the_Bodyheight * 0.02, color: Colors.red
          //     //                     // fontWeight: FontWeight.w300
          //     //                     ),
          //     //               )
          //     //             ],
          //     //           )
          //     //         ]),
          //     //       );
          //     //     },
          //     //   );
          //     // }
          //     return ListView.builder(
          //       itemCount: viewlist.length,
          //       itemBuilder: (context, index) {
          //         print("Length === ${viewlist.length}");
          //         return Container(
          //           decoration: BoxDecoration(
          //               border: Border.all(width: 1),
          //               borderRadius: BorderRadius.circular(10)),
          //           padding: EdgeInsets.all(the_Bodyheight * 0.02),
          //           margin: EdgeInsets.all(the_Bodyheight * 0.01),
          //           child: Column(children: [
          //             Container(
          //               child: imggg == ""
          //                   ? Container(
          //                       height: the_Bodyheight * 0.3,
          //                       width: thewidth * 0.6,
          //                       decoration: BoxDecoration(
          //                           image: DecorationImage(
          //                               image:
          //                                   NetworkImage("${viewlist[index].logo}"),
          //                               fit: BoxFit.contain)),
          //                     )
          //                   : Container(
          //                       child: Icon(Icons.camera_alt_outlined),
          //                     ),
          //             ),
          //             SizedBox(
          //               height: the_Bodyheight * 0.03,
          //             ),
          //             Row(
          //               children: [
          //                 Text(
          //                   "ID : ",
          //                   style: TextStyle(
          //                       fontSize: the_Bodyheight * 0.02,
          //                       fontWeight: FontWeight.w300),
          //                 ),
          //                 Text(
          //                   "${viewlist[index].id}",
          //                   style: TextStyle(
          //                       fontSize: the_Bodyheight * 0.02,
          //                       fontWeight: FontWeight.w300),
          //                 )
          //               ],
          //             ),
          //             Row(
          //               children: [
          //                 Text(
          //                   "Name : ",
          //                   style: TextStyle(
          //                       fontSize: the_Bodyheight * 0.02,
          //                       fontWeight: FontWeight.w300),
          //                 ),
          //                 Text(
          //                   "${viewlist[index].name}",
          //                   style: TextStyle(
          //                     fontSize: the_Bodyheight * 0.02,
          //                     // fontWeight: FontWeight.w300
          //                   ),
          //                 )
          //               ],
          //             ),
          //             Row(
          //               children: [
          //                 Text(
          //                   "Country : ",
          //                   style: TextStyle(
          //                       fontSize: the_Bodyheight * 0.02,
          //                       fontWeight: FontWeight.w300),
          //                 ),
          //                 Text(
          //                   "${viewlist[index].country}",
          //                   style: TextStyle(
          //                     fontSize: the_Bodyheight * 0.02,
          //                     // fontWeight: FontWeight.w300
          //                   ),
          //                 )
          //               ],
          //             ),
          //             Row(
          //               children: [
          //                 Text(
          //                   "Slogan : ",
          //                   style: TextStyle(
          //                       fontSize: the_Bodyheight * 0.02,
          //                       fontWeight: FontWeight.w300),
          //                 ),
          //                 Expanded(
          //                   child: Text(
          //                     "${viewlist[index].slogan}",
          //                     style: TextStyle(
          //                       fontSize: the_Bodyheight * 0.02,
          //                       // fontWeight: FontWeight.w300
          //                     ),
          //                   ),
          //                 )
          //               ],
          //             ),
          //             Row(
          //               children: [
          //                 Text(
          //                   "Head_Quaters : ",
          //                   style: TextStyle(
          //                       fontSize: the_Bodyheight * 0.02,
          //                       fontWeight: FontWeight.w300),
          //                 ),
          //                 Expanded(
          //                   child: Text(
          //                     "${viewlist[index].headQuaters}",
          //                     style: TextStyle(
          //                       fontSize: the_Bodyheight * 0.02,
          //                       // fontWeight: FontWeight.w300
          //                     ),
          //                   ),
          //                 )
          //               ],
          //             ),
          //             Row(
          //               children: [
          //                 Text(
          //                   "Website : ",
          //                   style: TextStyle(
          //                       fontSize: the_Bodyheight * 0.02,
          //                       fontWeight: FontWeight.w300),
          //                 ),
          //                 Text(
          //                   "${viewlist[index].website}",
          //                   style: TextStyle(
          //                       fontSize: the_Bodyheight * 0.02, color: Colors.blue
          //                       // fontWeight: FontWeight.w300
          //                       ),
          //                 )
          //               ],
          //             ),
          //             Row(
          //               children: [
          //                 Text(
          //                   "Established : ",
          //                   style: TextStyle(
          //                       fontSize: the_Bodyheight * 0.02,
          //                       fontWeight: FontWeight.w300),
          //                 ),
          //                 Text(
          //                   "${viewlist[index].established}",
          //                   style: TextStyle(
          //                       fontSize: the_Bodyheight * 0.02, color: Colors.red
          //                       // fontWeight: FontWeight.w300
          //                       ),
          //                 )
          //               ],
          //             )
          //           ]),
          //         );
          //       },
          //     );
          //   },
          // ),
          ),
    );
  }

  Future<bool> mainpagee() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return firstpage();
      },
    ));
    return Future.value(true);
  }
}

class My_Dataclass {
  dynamic? id;
  String? name;
  String? country;
  String? logo;
  String? slogan;
  String? headQuaters;
  String? website;
  String? established;

  My_Dataclass(
      {this.id,
      this.name,
      this.country,
      this.logo,
      this.slogan,
      this.headQuaters,
      this.website,
      this.established});

  My_Dataclass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    logo = json['logo'];
    slogan = json['slogan'];
    headQuaters = json['head_quaters'];
    website = json['website'];
    established = json['established'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country'] = this.country;
    data['logo'] = this.logo;
    data['slogan'] = this.slogan;
    data['head_quaters'] = this.headQuaters;
    data['website'] = this.website;
    data['established'] = this.established;
    return data;
  }
}
