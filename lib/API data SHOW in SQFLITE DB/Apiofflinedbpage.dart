import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:tabbar_project/API%20data%20SHOW%20in%20SQFLITE%20DB/ModelclassDB.dart';

class OfflineDB_page extends StatefulWidget {
  @override
  State<OfflineDB_page> createState() => _OfflineDB_pageState();
}

class _OfflineDB_pageState extends State<OfflineDB_page> {
  viewdata__List? linkdata;
  Database? DB1;
  List liiiist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    My_Fetchdata();
    Getviewdb();
  }

  My_Fetchdata() async {
    var url = Uri.parse(
        'https://www.7timer.info/bin/astro.php?lon=113.2&lat=23.1&ac=0&unit=metric&output=json&tzshift=0');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print("Datamy==${response.body.toString()}");

    if (response.statusCode == 200) {
      var ccc = jsonDecode(response.body);
      setState(() {
        linkdata = viewdata__List.fromJson(ccc);
      });
    }
  }

  Getviewdb() {
    DB_Model().Geting_DATA().then((value) {
      setState(() {
        DB1 = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Online DB show in offline"),
        centerTitle: true,
      ),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                int? title;
                int? name;
                int? no;

                for (int i = 0; i < linkdata!.dataseries!.length; i++) {
                  setState(() {
                    title = linkdata!.dataseries![i].timepoint;
                    name = linkdata!.dataseries![i].cloudcover;
                    no = linkdata!.dataseries![i].seeing;
                    DB_Model().Insertdata(title!, name!, no!, DB1!);

                    print(title);
                  });
                }

                DB_Model().Insertdata(title!, name!, no!, DB1!);

                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return Viewdataui();
                  },
                ));
              },
              child: Text("VIEW SQFLITE DATA"))),
    );
  }
}

class Viewdataui extends StatefulWidget {
  const Viewdataui({Key? key}) : super(key: key);

  @override
  State<Viewdataui> createState() => _ViewdatauiState();
}

class _ViewdatauiState extends State<Viewdataui> {
  Database? My_DB;
  List<Map> Data___View = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    VIEWDETAIL_data();
  }

  VIEWDETAIL_data() {
    DB_Model().Geting_DATA().then((value) {
      setState(() {
        My_DB = value;
      });
      DB_Model().ViewMY_Data(My_DB!).then((listOF_Map) {
        setState(() {
          Data___View = listOF_Map;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View SQFLITE DATA"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: Data___View.length,
        itemBuilder: (context, index) {
          print(Text("ppppp${Data___View}"));
          return ExpansionTile(
            title: Text("dataseries"),
            children: [
              Text("${Data___View[index]['title']}"),
              Text("${Data___View[index]['name']}"),
              Text("${Data___View[index]['no']}")
            ],
          );
        },
      ),
    );
  }
}

class viewdata__List {
  String? product;
  String? init;
  List<Dataseries>? dataseries;

  viewdata__List({this.product, this.init, this.dataseries});

  viewdata__List.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    init = json['init'];
    if (json['dataseries'] != null) {
      dataseries = <Dataseries>[];
      json['dataseries'].forEach((v) {
        dataseries!.add(new Dataseries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.product;
    data['init'] = this.init;
    if (this.dataseries != null) {
      data['dataseries'] = this.dataseries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dataseries {
  int? timepoint;
  int? cloudcover;
  int? seeing;
  int? transparency;
  int? liftedIndex;
  int? rh2m;
  Wind10m? wind10m;
  int? temp2m;
  String? precType;

  Dataseries(
      {this.timepoint,
      this.cloudcover,
      this.seeing,
      this.transparency,
      this.liftedIndex,
      this.rh2m,
      this.wind10m,
      this.temp2m,
      this.precType});

  Dataseries.fromJson(Map<String, dynamic> json) {
    timepoint = json['timepoint'];
    cloudcover = json['cloudcover'];
    seeing = json['seeing'];
    transparency = json['transparency'];
    liftedIndex = json['lifted_index'];
    rh2m = json['rh2m'];
    wind10m =
        json['wind10m'] != null ? new Wind10m.fromJson(json['wind10m']) : null;
    temp2m = json['temp2m'];
    precType = json['prec_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timepoint'] = this.timepoint;
    data['cloudcover'] = this.cloudcover;
    data['seeing'] = this.seeing;
    data['transparency'] = this.transparency;
    data['lifted_index'] = this.liftedIndex;
    data['rh2m'] = this.rh2m;
    if (this.wind10m != null) {
      data['wind10m'] = this.wind10m!.toJson();
    }
    data['temp2m'] = this.temp2m;
    data['prec_type'] = this.precType;
    return data;
  }
}

class Wind10m {
  String? direction;
  int? speed;

  Wind10m({this.direction, this.speed});

  Wind10m.fromJson(Map<String, dynamic> json) {
    direction = json['direction'];
    speed = json['speed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['direction'] = this.direction;
    data['speed'] = this.speed;
    return data;
  }
}
