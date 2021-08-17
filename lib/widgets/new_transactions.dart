import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    if (inputTitle.isEmpty ||
        inputAmount <= 0 ||
        _selectedDate == DateTime.utc(2000)) {
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
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
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
              style: Theme.of(context).textTheme.title,
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
              style: Theme.of(context).textTheme.title,
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
                  _selectedDate == DateTime.utc(2000)
                      ? Text(
                          'No date selected',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 39, 76, 1),
                            fontSize: 20.0,
                            fontFamily: 'Quicksand',
                          ),
                        )
                      : Text(
                          DateFormat.yMMMMEEEEd().format(_selectedDate),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 39, 76, 1),
                            fontSize: 20.0,
                            fontFamily: 'Quicksand',
                          ),
                        ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  ElevatedButton(
                    onPressed: _datePicker,
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 39, 76, 1),
                        fontSize: 18.0,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                  )
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
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Color.fromRGBO(0, 39, 76, 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
