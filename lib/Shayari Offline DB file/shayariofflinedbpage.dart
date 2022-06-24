import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tabbar_project/Shayari%20Offline%20DB%20file/Databaseclasspage.dart';
import 'package:tabbar_project/Shayari%20Offline%20DB%20file/Detailshayaripage.dart';

class ShayariDBpg extends StatefulWidget {
  @override
  State<ShayariDBpg> createState() => _ShayariDBpgState();
}

class _ShayariDBpgState extends State<ShayariDBpg> {
  Database? dbase;
  List<Map> viewdatalist = [];
  bool screeenstatus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      screeenstatus = true;
    });
    Getallviewdata();
  }

  Getallviewdata() {
    DbHelper().Getalldata().then((value) {
      setState(() {
        dbase = value;
      });
      DbHelper().Viewdatalist(dbase!).then((listofmap) {
        setState(() {
          viewdatalist = listofmap;
        });
        print("View==${viewdatalist}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double theheight = MediaQuery.of(context).size.height;
    double thewidth = MediaQuery.of(context).size.width;
    double theststuabar = MediaQuery.of(context).padding.top;
    double thenavigator = MediaQuery.of(context).padding.bottom;
    double theappbar = kToolbarHeight;
    double the_bodyheight = theheight - theststuabar - theappbar - thenavigator;
    return Scaffold(
      appBar: AppBar(
        title: Text("Shayari DB"),
        centerTitle: true,
      ),
      body: screeenstatus
          ? ListView.builder(
              itemCount: viewdatalist.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return detailshayari(viewdatalist, index);
                      },
                    ));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          color: Color(0xFFDCE8A3),
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(the_bodyheight * 0.01),
                      margin: EdgeInsets.all(the_bodyheight * 0.01),
                      height: the_bodyheight * 0.1,
                      child: Center(
                        child: Text(
                          "${viewdatalist[index]['name']}",
                          style: TextStyle(fontSize: the_bodyheight * 0.025),
                        ),
                      )),
                );
              },
            )
          : Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Please wait...   ",
                    style: TextStyle(fontSize: the_bodyheight * 0.04),
                  ),
                  SizedBox(
                    height: the_bodyheight * 0.05,
                  ),
                  CircularProgressIndicator(
                    backgroundColor: Colors.yellowAccent,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  ),
                ],
              ),
            ),
    );
  }
}
