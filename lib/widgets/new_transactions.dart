import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTrans;

  NewTransaction(this.addNewTrans);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitDate() {
    final inputTitle = titleController.text;
    final inputAmount = double.parse(amountController.text);

    if (inputTitle.isEmpty || inputAmount <= 0) {
      return;
    }

    //has a "widget" before the addNewTrans method is because addNewTrans method
    //is declared in another class, in order to use it, flutter adds "widget"
    widget.addNewTrans(inputTitle, inputAmount);

    //this method is used to automatically close the small screen after hit
    // submission button
    //pop: pop it off
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title:',
              ),
              controller: titleController,
              onSubmitted: (_) => submitDate,
              // //once the text field is changed, it passes the value(string)
              // //to a function
              // onChanged: (value) {
              //   inputTitle = value;
              // },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount:',
              ),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitDate,
            ),
            FlatButton(
              onPressed: submitDate,
              child: Text('Add transaction'),
              textColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
