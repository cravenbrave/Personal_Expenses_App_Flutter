import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:personal_expenses_app/models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> _trans;
  TransactionList(this._trans);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            //card setting
            child: Row(
              children: [
                //amount setting
                Container(
                  child: Text(
                    //${} automatically transfer variable into string
                    '\$${_trans[index].amount.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple, width: 1.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 1.5, horizontal: 3.0),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //title and date setting
                  children: [
                    Text(
                      _trans[index].title,
                      style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DateFormat.yMMMMEEEEd().format(_trans[index].date),
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: _trans.length,
      ),
    );
  }
}
