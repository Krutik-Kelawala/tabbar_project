import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabbar_project/main.dart';

class provider2methodpage extends StatelessWidget {
  // TODO THIS SECOND METHOD
  // in this page we use second method of provider
  // Create object through provider work
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("With OBJECT method"),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (context) => ProviderMethod2(),
        child: providerdesign(),
      ),
    );
  }
}

class ProviderMethod2 extends ChangeNotifier {
  int abc = 0;

  increment() {
    abc++;
    notifyListeners();
  }

  decrement() {
    abc--;
    notifyListeners();
  }
}

class providerdesign extends StatefulWidget {
  @override
  State<providerdesign> createState() => _providerdesignState();
}

class _providerdesignState extends State<providerdesign> {
  @override
  Widget build(BuildContext context) {
    ProviderMethod2 provider = Provider.of(context);

    return Scaffold(
      body: WillPopScope(
        onWillPop: mainpg,
        child: SafeArea(
            child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text("${provider.abc}"),
              ElevatedButton(
                  onPressed: () => provider.increment(),
                  child: Text("Increment")),
              ElevatedButton(
                  onPressed: () => provider.decrement(),
                  child: Text("Decrement"))
            ],
          ),
        )),
      ),
    );
  }

  Future<bool> mainpg() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return firstpage();
      },
    ));
    return Future.value(true);
  }
}
