import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {

 final List<Transaction> recentTransaction;

 Chart(this.recentTransaction);

 List<Map<String, Object>> get groupedTransaction {
  return List.generate(7, (index) {
    final weekDay = DateTime.now().subtract(
      Duration(days: index),
    );

    double totalSum = 0.0;

    for(var i = 0; i < recentTransaction.length; i++){
     bool sameDay = recentTransaction[i].date.day == weekDay.day;
     bool sameMonth = recentTransaction[i].date.day == weekDay.month;
     bool sameYear = recentTransaction[i].date.day == weekDay.year;
    
     if(sameDay && sameMonth && sameYear){
      totalSum += recentTransaction[i].value;
     }
    }

    print(DateFormat.E().format(weekDay)[0]);
    print(totalSum);

    return {
     'day': DateFormat.E().format(weekDay)[0],
     'value': totalSum, 
     };
  });
 }

  @override
  Widget build(BuildContext context) {
    return Card(
    elevation: 6,
    margin: EdgeInsets.all(20),
    child: Row(
      children: <Widget>[],
    )
    );
  }
}