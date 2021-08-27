import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double percentOfTotal;

  ChartBar(this.label, this.amount, this.percentOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      //constrains used to get the height and width info from flutter internal
      //methods
      builder: (context, constrains) {
        return Column(
          children: [
            Container(
              height: constrains.maxHeight * 0.2,
              child: FittedBox(
                child: Text(
                  '\$${amount.toStringAsFixed(0)}',
                  style: TextStyle(color: Color.fromRGBO(255, 203, 5, 1)),
                ),
              ),
            ),
            SizedBox(
              height: constrains.maxHeight * 0.05,
            ),
            Container(
              height: constrains.maxHeight * 0.55,
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
                  FractionallySizedBox(
                    heightFactor: percentOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.white, width: 2.0),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: constrains.maxHeight * 0.05,
            ),
            Container(
              height: constrains.maxHeight * 0.15,
              //used fittedBox to make sure the text is shown, if it is a very small device
              //by shrinking the font size
              child: FittedBox(
                child: Text(
                  label,
                  style: TextStyle(color: Color.fromRGBO(255, 203, 5, 1)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
