import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tabbar_project/main.dart';

class streambuilderpage extends StatefulWidget {
  @override
  State<streambuilderpage> createState() => _streambuilderpageState();
}

class _streambuilderpageState extends State<streambuilderpage> {
  final apicalling providerr = apicalling();

  @override
  void initState() {
    super.initState();

    providerr.myviewdata();
  }

  @override
  Widget build(BuildContext context) {
    double theheight = MediaQuery.of(context).size.height;
    double thewidth = MediaQuery.of(context).size.width;
    double theststuabar = MediaQuery.of(context).padding.top;
    double thenavigator = MediaQuery.of(context).padding.bottom;
    double theappbar = kToolbarHeight;
    double the_bodyheight = theheight - theststuabar - theappbar - thenavigator;
    // apicalling providerrr = Provider.of(context);
    return WillPopScope(
      onWillPop: backpagee,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Provider through apicalling"),
          centerTitle: true,
        ),
        body: ChangeNotifierProvider<apicalling>(
          create: (context) => providerr,
          child: Consumer<apicalling>(
            builder: (context, providerr, child) {
              return providerr.loading
                  ? Scaffold(
                      body: SafeArea(
                          child: ListView.builder(
                        itemCount: providerr.view!.data!.length,
                        itemBuilder: (context, index) {
                          print("lenth === ${providerr.view!.data!.length}");
                          return Container(
                            margin: EdgeInsets.all(the_bodyheight * 0.01),
                            decoration:
                                BoxDecoration(border: Border.all(width: 1)),
                            padding: EdgeInsets.all(the_bodyheight * 0.01),
                            height: the_bodyheight * 0.15,
                            width: double.infinity,
                            child: Consumer<apicalling>(
                                builder: (context, providerr, child) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "ID : ${providerr.view!.data![index].id}",
                                          style: TextStyle(
                                              fontSize: the_bodyheight * 0.02),
                                        ),
                                        Text(
                                          "Emplyee Name : ${providerr.view!.data![index].employeeName}",
                                          style: TextStyle(
                                              fontSize: the_bodyheight * 0.02),
                                        ),
                                        Text(
                                          "Emplyee Salary : ${providerr.view!.data![index].employeeSalary}",
                                          style: TextStyle(
                                              fontSize: the_bodyheight * 0.02),
                                        ),
                                        Text(
                                          "Emplyee Age : ${providerr.view!.data![index].employeeAge}",
                                          style: TextStyle(
                                              fontSize: the_bodyheight * 0.02),
                                        ),
                                      ],
                                    )),
                          );
                        },
                      )),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: Colors.yellow,
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }

  Future<bool> backpagee() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return firstpage();
      },
    ));
    return Future.value(true);
  }
}

class apicalling extends ChangeNotifier {
  Response? response;
  var dio = Dio();
  mydata? view;
  var getdata;
  bool loading = false;

  myviewdata() async {
    // response =
    //     await dio.get('https://dummy.restapiexample.com/api/v1/employees');
    // getdata = jsonDecode(response.toString());
    // view = mydata.fromJson(getdata);
    // loading = true;
    // notifyListeners();
    // print("Data=== ${response.toString()}");

    var url = Uri.parse('https://dummy.restapiexample.com/api/v1/employees');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    getdata = jsonDecode(response.body);
    view = mydata.fromJson(getdata);
    loading = true;
    notifyListeners();
    print("Data=== ${response.body}");

    /*if (response.statusCode == 200) {
      getdata = jsonDecode(response.body);
      view = mydata.fromJson(getdata);
      loading = true;
      notifyListeners();
      print("Data=== ${response.body}");
    } else {
      print("Something Wrong ");
    }*/
  }
}

class mydata {
  String? status;
  List<Data>? data;
  String? message;

  mydata({this.status, this.data, this.message});

  mydata.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? employeeName;
  int? employeeSalary;
  int? employeeAge;
  String? profileImage;

  Data(
      {this.id,
      this.employeeName,
      this.employeeSalary,
      this.employeeAge,
      this.profileImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeName = json['employee_name'];
    employeeSalary = json['employee_salary'];
    employeeAge = json['employee_age'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_name'] = this.employeeName;
    data['employee_salary'] = this.employeeSalary;
    data['employee_age'] = this.employeeAge;
    data['profile_image'] = this.profileImage;
    return data;
  }
}
