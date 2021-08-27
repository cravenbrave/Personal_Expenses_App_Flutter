import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses_app/widgets/new_transactions.dart';
import 'package:personal_expenses_app/models/transactions.dart';
import 'package:personal_expenses_app/widgets/transaction_list.dart';
import 'package:personal_expenses_app/widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //limit the screen rotation function. Need to import services.dart
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,

    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application. Set up global theme
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              subtitle1: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(0, 39, 76, 1),
              ),
            ),
        //light means the default setting
        appBarTheme: AppBarTheme(
          color: Color.fromRGBO(0, 39, 76, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
                subtitle1: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(255, 203, 5, 1),
                ),
              ),
          iconTheme: ThemeData.light().iconTheme.copyWith(
                color: Color.fromRGBO(255, 203, 5, 1),
              ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber)
            .copyWith(secondary: Color.fromRGBO(0, 39, 76, 1)),
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
  final List<Transactions> _trans = [
    // Transactions(6, 'Foodfghjhgghjghdfewrwerwghjhj', 156776.0, DateTime.now()),
    // Transactions(0, 'Restaurant', 31.32, DateTime.now()),
    // Transactions(1, 'Kroger', 25.63, DateTime.now()),
    // Transactions(2, 'Pet Supplies', 28.60, DateTime.now()),
    // Transactions(3, 'Costco', 109.2, DateTime.now()),
    // Transactions(5, 'Take-out', 32.3, DateTime.now()),
  ];

  //only returns the recent 7 days trans to chart
  List<Transactions> get _recentTrans {
    return _trans.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTrans(
      String transTitle, double transAmount, DateTime chosenDate) {
    final newTrans =
        Transactions(_trans.length, transTitle, transAmount, chosenDate);

    setState(() {
      _trans.add(newTrans);
    });
  }

  void _removeTrans(int id) {
    setState(() {
      _trans.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  //the function used to floatButton add on pressed
  void _startAddNewTrans(BuildContext context) {
    //built-in function by flutter, a new window which doesn't interact with
    //the original screen, create a new small screen
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          child: NewTransaction(_addNewTrans),
          //these two methods are used to avoid tap the blank at the new screen
          //to close, HitTestBehavior is used to catch all taps and do nothing
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        'Personal Expenses',
        textAlign: TextAlign.right,
        style: TextStyle(
          fontFamily: 'OpenSans',
          color: Color.fromRGBO(255, 203, 5, 1),
          fontWeight: FontWeight.bold,
          fontSize: 26.0,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () => _startAddNewTrans(context),
            icon: Icon(
              Icons.add,
              size: 28.0,
            )),
      ],
    );
    return Scaffold(
      appBar: appBar,
      //used to change the float button location
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Color.fromRGBO(255, 203, 5, 1),
          size: 30,
        ),
        onPressed: () => _startAddNewTrans(context),
      ),
      body: SingleChildScrollView(
        // Single scroll view fixes the out of screen bound error
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                //mediaQuery get the device info, size etc, we get the device height
                //and then rule this container uses 0.6 of the height of the screen
                //appBar preferredSize is the height of the appBar
                //also minus padding size (more likely designed for android?
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.21,
                child: Chart(_recentTrans)),
            // Card(
            //   child: Container(
            //     margin: EdgeInsets.all(10.0),
            //     width: double.infinity,
            //     alignment: Alignment.center,
            //     child: Text('Chart'),
            //   ),
            //   elevation: 1.0,
            // ),
            Container(
                child: TransactionList(_trans, _removeTrans),
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.79),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
