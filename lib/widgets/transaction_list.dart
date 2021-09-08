import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import 'package:personal_expenses_app/models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> _trans;
  final Function _removeTrans;
  TransactionList(this._trans, this._removeTrans);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: _trans.isEmpty
          ? LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.05),
                  Text(
                    'No transactions added yet',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  //we can use
                  SizedBox(height: constraints.maxHeight * 0.05),
                  //to create a space btw text and image as well
                  // Spacer(),
                  Container(
                      padding: EdgeInsets.only(top: 20.0),
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assests/images/waiting.png',
                        //used to set the image size fit the screen
                        //also need container to set the size first
                        fit: BoxFit.cover,
                      )),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                  //card setting
                  child: Container(
                    height: 80,
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: ListTile(
                      leading: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(255, 203, 5, 1),
                        ),
                        child: FittedBox(
                          child: Text(
                            '\$${_trans[index].amount.toStringAsFixed(2)}',
                          ),
                        ),
                      ),
                      //can use a pre-installed widget to set a circle too
                      // CircleAvatar(
                      //   backgroundColor: Color.fromRGBO(255, 203, 5, 1),
                      //   radius: 50,
                      //   child: FittedBox(
                      //     child: Text(
                      //       '\$${_trans[index].amount.toStringAsFixed(2)}',
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      title: Text(
                        _trans[index].title,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(255, 203, 5, 1)),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMMEEEEd().format(_trans[index].date),
                        style: TextStyle(color: Colors.black54),
                      ),
                      trailing: MediaQuery.of(context).size.width > 500
                          ? TextButton.icon(
                              style: TextButton.styleFrom(primary: Colors.red),
                              onPressed: () => _removeTrans(_trans[index].id),
                              label: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                              icon: const Icon(Icons.delete),
                            )
                          : IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () => _removeTrans(_trans[index].id),
                            ),
                    ),
                  ),
                  // child: Row(
                  //   children: [
                  //     //amount setting
                  //     Flexible(
                  //       fit: FlexFit.tight,
                  //       child: Container(
                  //         child: Text(
                  //           //${} automatically transfer variable into string
                  //           //toStringAsFixed is fixed the decimal with only 2 digits
                  //           '\$${_trans[index].amount.toStringAsFixed(2)}',
                  //           style: TextStyle(
                  //               fontSize: 30.0,
                  //               fontWeight: FontWeight.bold,
                  //               color: Color.fromRGBO(255, 203, 5, 1)),
                  //         ),
                  //         margin: EdgeInsets.symmetric(
                  //             vertical: 5.0, horizontal: 20.0),
                  //         // decoration: BoxDecoration(
                  //         //   border: Border.all(color: Colors.blue, width: 2.0),
                  //         // ),
                  //         padding: EdgeInsets.symmetric(
                  //             vertical: 1.5, horizontal: 3.0),
                  //       ),
                  //     ),
                  //     Flexible(
                  //       fit: FlexFit.tight,
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         //title and date setting
                  //         children: [
                  //           Text(
                  //             _trans[index].title,
                  //             style: TextStyle(
                  //                 fontSize: 20.0,
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Color.fromRGBO(255, 203, 5, 1)),
                  //           ),
                  //           Text(
                  //             DateFormat.yMMMMEEEEd().format(_trans[index].date),
                  //             style: TextStyle(color: Colors.black54),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                );
              },
              itemCount: _trans.length,
            ),
    );
  }
}
