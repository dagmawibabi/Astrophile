import 'package:astrophile/pages/FetchData.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  void getInitialData() async {
    print("started");
    FetchData instance = FetchData();
    await instance
        .getAPOTD("2020-11-13" /*DateTime.now().toString().substring(0, 10)*/);
    print("got");
    Map instanceData = instance.instanceData;
    Navigator.pushReplacementNamed(context, "home",
        arguments: {"instanceData": instanceData});
    print("done");
  }

  @override
  void initState() {
    super.initState();
    getInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/1.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100.0),
              Text(
                "ASTROPHILE",
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 40.0,
                  fontFamily: "Aladin",
                ),
              ),
              SizedBox(height: 130.0),
              Text(
                "Made By Dream Intelligence \nNov 2020GC",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
