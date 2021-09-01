import 'dart:io';

import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses_app/widgets/adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTrans;

  NewTransaction(this.addNewTrans);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.utc(2000);

  void _submitDate() {
    //nothing happened when is empty, without send an error
    if (_amountController.text.isEmpty) {
      return;
    }

    final inputTitle = _titleController.text;
    final inputAmount = double.parse(_amountController.text);

    //if any content is wrong, return nothing as well
    if (inputTitle.isEmpty || inputAmount <= 0 || _selectedDate == DateTime.utc(2000)) {
      return;
    }

    //has a "widget" before the addNewTrans method is because addNewTrans method
    //is declared in another class, in order to use it, flutter adds "widget"
    widget.addNewTrans(inputTitle, inputAmount, _selectedDate);

    //this method is used to automatically close the small screen after hit
    // submission button
    //pop: pop it off
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 4.0,
        child: Container(
          padding: EdgeInsets.only(
              left: 10, top: 10, right: 10, bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                style: Theme.of(context).textTheme.subtitle1,
                decoration: InputDecoration(
                  labelText: 'Title:',
                ),
                controller: _titleController,
                onSubmitted: (_) => _submitDate,
                // //once the text field is changed, it passes the value(string)
                // //to a function
                // onChanged: (value) {
                //   inputTitle = value;
                // },
              ),
              TextField(
                style: Theme.of(context).textTheme.subtitle1,
                decoration: InputDecoration(
                  labelText: 'Amount:',
                ),
                controller: _amountController,
                //enable the keyboard to type decimal
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitDate,
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Date: ',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20.0,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                    if (_selectedDate != DateTime.utc(2000))
                      Text(
                        DateFormat.yMMMMEEEEd().format(_selectedDate),
                        style: TextStyle(
                          color: Color.fromRGBO(0, 39, 76, 1),
                          fontSize: 20.0,
                          fontFamily: 'Quicksand',
                        ),
                      ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    AdaptiveFlatButton('Add date', _datePicker),
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              ElevatedButton(
                onPressed: _submitDate,
                child: Text(
                  'Add transaction',
                  style: TextStyle(
                      fontFamily: 'QuickSand',
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Color.fromRGBO(0, 39, 76, 1)),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            ],
          ),
        ),
      ),
    );
  }
}
