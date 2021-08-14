import 'package:flutter/foundation.dart';

class Transactions {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transactions(this.id, this.title, this.amount, this.date);
//   Transactions(this.amount, this.date, {
//     required this.id,
//     required this.title;
//     required this.amount;
//     required this.date;
// });
}
