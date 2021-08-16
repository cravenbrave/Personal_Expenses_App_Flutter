import 'package:flutter/material.dart';

import 'new_transactions.dart';
import 'transaction_list.dart';
import 'package:personal_expenses_app/models/transactions.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({Key? key}) : super(key: key);

  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transactions> _trans = [
    Transactions('t1', 'Food', 15.0, DateTime.now()),
    Transactions('t2', 'Grocery', 20.0, DateTime.now()),
    Transactions('t2', 'Take-out', 32.3, DateTime.now()),
  ];

  void _addNewTrans(String transTitle, double transAmount) {
    final newTrans = Transactions(
        DateTime.now().toString(), transTitle, transAmount, DateTime.now());

    setState(() {
      _trans.add(newTrans);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTrans),
        TransactionList(_trans),
      ],
    );
  }
}
