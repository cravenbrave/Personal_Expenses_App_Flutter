import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './transactions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transactions> trans = [
    Transactions('t1', 'Food', 15.0, DateTime.now()),
    Transactions('t2', 'Grocery', 20.0, DateTime.now()),
    Transactions('t2', 'Take-out', 32.3, DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              child: Container(
                margin: EdgeInsets.all(10.0),
                width: double.infinity,
                alignment: Alignment.center,
                child: Text('Chart'),
              ),
              elevation: 1.0,
            ),
            Column(
              children: trans.map((tt) {
                return Card(
                  //card setting
                  child: Row(
                    children: [
                      //amount setting
                      Container(
                        child: Text(
                          //${} automatically transfer variable into string
                          '\$${tt.amount}',
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple),
                        ),
                        margin: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 20.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 1.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 1.5, horizontal: 3.0),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //title and date setting
                        children: [
                          Text(
                            tt.title,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat.yMMMMEEEEd().format(tt.date),
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
