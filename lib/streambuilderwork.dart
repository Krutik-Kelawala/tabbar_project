import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tabbar_project/main.dart';

class streambuilderpage extends StatefulWidget {
  @override
  State<streambuilderpage> createState() => _streambuilderpageState();
}

class _streambuilderpageState extends State<streambuilderpage> {
  Response? response;
  var dio = Dio();
  mydata? view;
  var data;
  StreamController<String> mm = StreamController<String>();

  @override
  void initState() {
    super.initState();

    myviewdata();
  }

  myviewdata() async {
    response =
        await dio.get('https://dummy.restapiexample.com/api/v1/employees');
    print(response.toString());

    print("data==${response.toString()}");

    data = jsonDecode(response.toString());
    setState(() {
      view = mydata.fromJson(data);
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
        title: Text("Stream Builder"),
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: backpagee,
        child: StreamBuilder(
          stream: mm.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: the_bodyheight * 0.09,
                    ),
                    CircularProgressIndicator(
                      backgroundColor: Colors.yellow,
                    ),
                    SizedBox(
                      height: the_bodyheight * 0.05,
                    ),
                    Text(
                      "Please Wait....",
                      style: TextStyle(fontSize: the_bodyheight * 0.025),
                    )
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: view!.data!.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(the_bodyheight * 002),
                  child: Column(
                    children: [
                      // Text("Status : ${view!.status}"),
                      Text("ID : ${view!.data![index].id}"),
                      Text(
                          "Employee Name : ${view!.data![index].employeeName}"),
                      Text(
                          "Emplyee Salary : ${view!.data![index].employeeSalary}"),
                      Text("Emplyee Age : ${view!.data![index].employeeAge}")
                    ],
                  ),
                );
              },
            );

            // else if (snapshot.connectionState == ConnectionState.done ||
            //     snapshot.connectionState == ConnectionState.active) {
            //   if (snapshot.hasError) {
            //     return Text("Error");
            //   } else if (snapshot.hasData) {
            //     return ListView.builder(
            //       itemCount: view!.data!.length,
            //       itemBuilder: (context, index) {
            //         return Container(
            //           padding: EdgeInsets.all(the_bodyheight * 002),
            //           child: Column(
            //             children: [
            //               // Text("Status : ${view!.status}"),
            //               Text("ID : ${view!.data![index].id}"),
            //               Text(
            //                   "Employee Name : ${view!.data![index].employeeName}"),
            //               Text(
            //                   "Emplyee Salary : ${view!.data![index].employeeSalary}"),
            //               Text(
            //                   "Emplyee Age : ${view!.data![index].employeeAge}")
            //             ],
            //           ),
            //         );
            //       },
            //     );
            //   } else {
            //     return Text("Empty Data");
            //   }
            // } else {
            //   return Text("Status : ${snapshot.connectionState}");
            // }
          },
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
