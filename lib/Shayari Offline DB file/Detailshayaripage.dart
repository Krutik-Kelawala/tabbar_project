import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:tabbar_project/Shayari%20Offline%20DB%20file/Databaseclasspage.dart';
import 'package:tabbar_project/main.dart';

class detailshayari extends StatefulWidget {
  List<Map> viewdatalist;
  int index;

  detailshayari(this.viewdatalist, this.index);

  @override
  State<detailshayari> createState() => _detailshayariState();
}

class _detailshayariState extends State<detailshayari> {
  Database? dbase1;
  List<Map> view_shyarilist1 = [];
  bool loadinggg = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    detaishayariget();
  }

  detaishayariget() {
    DbHelper().Getalldata().then((value) {
      setState(() {
        dbase1 = value;
      });
      DbHelper().Viewdetailshy(dbase1!).then((listofshayri) {
        setState(() {
          loadinggg = true;
          view_shyarilist1 = listofshayri;
        });
        print("Vieww== ${view_shyarilist1}");
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
    return WillPopScope(
      onWillPop: firstpagecall,
      child: Scaffold(
        appBar: AppBar(
          title: Text("${widget.viewdatalist[widget.index]['name']}"),
          centerTitle: true,
        ),
        body: loadinggg
            ? ListView.builder(
                itemCount: view_shyarilist1.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(the_bodyheight * 0.005),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        border: Border.all(width: 1),
                        color: Color(0xFFA3E8E2)),
                    padding: EdgeInsets.all(the_bodyheight * 0.02),
                    child: Text(
                      "${view_shyarilist1[index]['Shayari']}",
                    ),
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
      ),
    );
  }

  Future<bool> firstpagecall() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return firstpage();
      },
    ));
    return Future.value(true);
  }
}
