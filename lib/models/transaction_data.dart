import 'dart:collection';
import 'package:expressed/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TransactionData extends ChangeNotifier {
  List<Transaction> _transactions = [
    Transaction(id: '1', title: 'Shopping', amount: 32.5, dateTime: DateTime.now()),
    Transaction(id: '2', title: 'Buy a Coffee', amount: 12.5, dateTime: DateTime.now()),
    Transaction(id: '3', title: 'Buy a Laptop', amount: 100.5, dateTime: DateTime.now()),
  ];

  UnmodifiableListView<Transaction> get transactions  {
    return UnmodifiableListView(_transactions);
  }

  int get transactionLength {
    return transactions.length;
  }

  bool get isEmty {
    return transactions.isEmpty;
  }

  List<Transaction> get recentTransactions {
    return _transactions.where((tx) {
      return tx.dateTime.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }

  void updateTransaction(Transaction transaction) {
    for (var tx in _transactions) {
      if (tx.id == transaction. id) {
        tx.title = transaction.title;
        tx.amount = transaction.amount;
        tx.dateTime = transaction.dateTime;
        break;
      }
    }
    notifyListeners();
  }

  void deleteTransaction(Transaction transaction) {
    _transactions.remove(transaction);
    notifyListeners();
  }

}