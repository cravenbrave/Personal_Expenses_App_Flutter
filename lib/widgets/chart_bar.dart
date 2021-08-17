import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double percentOfTotal;

  ChartBar(this.label, this.amount, this.percentOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          child: FittedBox(
            child: Text(
              '\$${amount.toStringAsFixed(0)}',
              style: TextStyle(color: Color.fromRGBO(255, 203, 5, 1)),
            ),
          ),
        ),
        SizedBox(
          height: 4.0,
        ),
        Container(
          height: 60,
          width: 15,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  // border: Border.all(
                  //     color: Colors.white, width: 1.0),
                  color: Color.fromRGBO(255, 203, 5, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(heightFactor: percentOfTotal,
              child: Container(
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.white, width: 2.0),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),),
            ],
          ),
        ),
        SizedBox(
          height: 4.0,
        ),
        Text(
          label,
          style: TextStyle(color: Color.fromRGBO(255, 203, 5, 1)),
        ),
      ],
    );
  }
}
