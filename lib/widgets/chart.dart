import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/models/transactions.dart';
import 'package:personal_expenses_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTrans;
  Chart(this.recentTrans);

  //getter is those properties calculated dynamically
  //return type, getter, method name
  List<Map<String, Object>> get groupRecentTrans {
    //total return 7 list element, each one is a map<String, Object>
    //pass the index into the generator
    return List.generate(7, (index) {
      //used to make which weekday is it
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var sum = 0.0;

      //iterate each recentTrans
      //for dart, it can also use
      //for (var xx in recentTrans), xx is the the one we want to use
      for (int i = 0; i < recentTrans.length; i++) {
        //make sure we are comparing the same date
        if (DateFormat.yMMMEd().format(recentTrans[i].date) ==
            DateFormat.yMMMEd().format(weekDay)) {
          //sum the amount of trans on that day
          sum += recentTrans[i].amount;
        }
      }
      return {
        //the weekday's short abbrev: M T W T F S S
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': sum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    //fold is to change the list type to another type based on our setting
    //initial value, (previous value, element) => (method)
    return groupRecentTrans.fold(0.0, (sum, element) {
      double amount = element['amount'] as double;
      return sum + amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(0, 39, 76, 1),
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupRecentTrans.map((element) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  '${element['day']}',
                  (element['amount'] as double),
                  //checking whether totalSpending is 0 or not, because totalSpending
                  //is the denominator
                  totalSpending == 0
                      ? 0.0
                      : ((element['amount'] as double) / totalSpending)),
            );
            // Text('${element['day']}: ${element['amount']}');
          }).toList(),
        ),
      ),
    );
  }
}
