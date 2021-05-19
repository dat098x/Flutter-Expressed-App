import 'package:expressed/screens/update_transaction_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final String id;
  final String title;
  final double amount;
  final DateTime dateTime;
  final Function deleteTransaction;
  final Function updateTransaction;

  TransactionCard({this.id, this.title, this.amount, this.dateTime, this.deleteTransaction, this.updateTransaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white)
        ),
        onLongPress: () {
          showModalBottomSheet(context: context, builder: (context) {
            return UpdateTransaction(
              id: id,
              title: title,
              amount: amount,
              date: dateTime,
              updateTransaction: updateTransaction,
            );
          });
        },
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(50)
            ),
            child: Text('\$${amount}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          title: Text('$title',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
            ),
          ),
          subtitle: Text(DateFormat.yMMMd().format(dateTime)),
          trailing: IconButton(
              icon: Icon(Icons.delete),
              color: Colors.redAccent,
              onPressed: () => deleteTransaction(id),
          )
        ),
      ),
    );
  }
}
