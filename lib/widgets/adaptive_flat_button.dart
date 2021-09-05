import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onTapped;
  AdaptiveFlatButton(this.buttonName, this.onTapped);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              buttonName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(0, 39, 76, 1),
                fontSize: 20.0,
                fontFamily: 'Quicksand',
              ),
            ),
            onPressed: onTapped)
        : ElevatedButton(
            onPressed: onTapped,
            child: Text(
              buttonName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(0, 39, 76, 1),
                fontSize: 20.0,
                fontFamily: 'Quicksand',
              ),
            ),
          );
  }
}
