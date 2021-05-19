import 'dart:math';
import 'package:expressed/models/transaction.dart';
import 'package:expressed/screens/update_transaction_screen.dart';
import 'package:expressed/widgets/chart.dart';
import 'package:expressed/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<Transaction> userTransactions = [
    Transaction(id: '1', title: 'Shopping', amount: 32.5, dateTime: DateTime.now()),
    Transaction(id: '2', title: 'Buy a Coffee', amount: 12.5, dateTime: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return userTransactions.where((tx) {
      return tx.dateTime.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addUserTransaction(String title,double amount, DateTime selectedDate) {
    final newTransation = Transaction(id: Random().nextInt(1000).toString() , title: title, amount: amount, dateTime: selectedDate);
    setState(() {
      userTransactions.add(newTransation);
    });
    Navigator.pop(context);
  }

  void _updateUserTransaction(String id, String title, double amount, DateTime selectedDate) {
      setState(() {
        for (var transaction in userTransactions) {
          if (transaction.id == id) {
            transaction.title = title;
            transaction.amount = amount;
            transaction.dateTime = selectedDate;
            break;
          }
        }
      }
    );
      Navigator.pop(context);
  }

  void _deleteUserTransaction(String id) {
    print('Delete');
    setState(() {
      userTransactions.removeWhere((tx) => tx.id == id);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expressed'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(context: context, builder: (context) => UpdateTransaction(
            updateTransaction: _addUserTransaction,
          ));
          print('here');
        },
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Chart(_recentTransactions),
              Expanded(
                child: TransactionList(
                  transactions: userTransactions,
                  deleteTransaction: _deleteUserTransaction,
                  updateTransaction: _updateUserTransaction,
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
