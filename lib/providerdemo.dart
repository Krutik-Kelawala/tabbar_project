import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class providepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO THIS SECOND METHOD
    // providerdemo mmm = Provider.of<providerdemo>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Without Object method"),
          centerTitle: true,
        ),
        body: ChangeNotifierProvider(
          create: (context) => providerdemo(),
          child: Consumer<providerdemo>(
            builder: (context, value, child) {
              return SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text("${value.cnt}"),
                      ElevatedButton(
                          onPressed: () {
                            value.increment();
                          },
                          child: Text("Increment")),
                      SizedBox(
                        height: 20,
                      ),
                      // Text("${value.cnt}"),
                      ElevatedButton(
                          onPressed: () {
                            value.Decrement();
                          },
                          child: Text("Decrement")),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }


}

class providerdemo extends ChangeNotifier {
  int cnt = 0;
  int abc = 0;

  increment() {
    cnt++;
    notifyListeners();
  }

  Decrement() {
    cnt--;
    notifyListeners();
  }
}
