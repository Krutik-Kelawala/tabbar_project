import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tabbar_project/futurebuilderpg.dart';
import 'package:tabbar_project/getxpage.dart';
import 'package:tabbar_project/providerdemo.dart';
import 'package:tabbar_project/providermethod2.dart';
import 'package:tabbar_project/shayariofflinedbpage.dart';
import 'package:tabbar_project/streambuilderwork.dart';

void main() {
  runApp(MaterialApp(
    home: firstpage(),
  ));
}

class firstpage extends StatefulWidget {
  const firstpage({Key? key}) : super(key: key);

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  int selectindex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        endDrawer: Drawer(
            child: ListView(
          children: [
            ListTile(
              onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => streambuilderpage(),
                  )),
              leading: Icon(Icons.add_circle),
              title: Text("Apicall through provider"),
            )
          ],
        )),
        appBar: AppBar(
          title: Text("Tabbar"), leading: Icon(Icons.adb),
          // centerTitle: true,
          bottom: TabBar(tabs: [
            Tab(
              icon: Icon(Icons.chat),
              text: "Chats",
            ),
            Tab(
              icon: Icon(Icons.add_a_photo_rounded),
              text: "Camera",
            ),
            Tab(
              icon: Icon(Icons.call),
              text: "Calls",
            )
          ]),
        ),
        body: Center(
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return providepage();
                    },
                  ));
                },
                child: Text("Provider page")),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => provider2methodpage(),
                    )),
                child: Text("Provider Method 2")),
            SizedBox(
              height: 20,
            ),
            IconButton(
                onPressed: () async {
                  var status = await Permission.camera.status;
                  if (status.isDenied) {
                    // We didn't ask for permission yet or the permission has been denied before but not permanently.

                    await [
                      Permission.camera,
                      Permission.storage,
                      Permission.location,
                    ].request();
                  }
                },
                icon: Icon(Icons.add_a_photo)),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return Getxmethodpg();
                    },
                  ));
                },
                child: Text("GetX Method page")),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return ShayariDBpg();
                    },
                  ));
                },
                child: Text("Shayari DB")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return Futurebuildpage();
                    },
                  ));
                },
                child: Text("Future Builder"))
          ]),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                backgroundColor: Colors.yellow,
                icon: Icon(Icons.call_missed),
                label: "Miss call"),
            BottomNavigationBarItem(
                backgroundColor: Colors.blue,
                icon: Icon(Icons.cloud),
                label: "Recent")
          ],
          currentIndex: selectindex,
          onTap: Ontapitem,
        ),
      ),
    );
  }

  void Ontapitem(int value) {
    setState(() {
      selectindex = value;
    });
  }
}
