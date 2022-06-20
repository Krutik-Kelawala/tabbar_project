import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabbar_project/main.dart';

class Getxmethodpg extends StatefulWidget {
  @override
  State<Getxmethodpg> createState() => _GetxmethodpgState();
}

class _GetxmethodpgState extends State<Getxmethodpg> {
  TextEditingController a1 = TextEditingController();
  TextEditingController a2 = TextEditingController();
  Getxdemo aaa = Get.put(Getxdemo());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: firstpggg,
      child: Scaffold(
        appBar: AppBar(
          title: Text("GetX Method"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: a1,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: a2,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  aaa.sumcalculate(a1.text, a2.text);
                },
                child: Text("Calculate Sum")),
            SizedBox(
              height: 10,
            ),
            Obx(() => Text(
                  "${aaa.sum.value}",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.red,
                      backgroundColor: Colors.yellow),
                ))
          ]),
        ),
      ),
    );
  }

  Future<bool> firstpggg() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return firstpage();
      },
    ));
    return Future.value(true);
  }
}

class Getxdemo extends GetxController {
  RxString sum = "".obs;
  double p = 0;
  double q = 0;

  void sumcalculate(String a1, String a2) {
    if (a1.isNotEmpty) {
      p = double.parse(a1);
    } else {
      p = 0;
    }
    if (a2.isNotEmpty) {
      q = double.parse(a2);
    } else {
      q = 0;
    }

    double c = p + q;
    sum.value = c.toString();
  }
}
