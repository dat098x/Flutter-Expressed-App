import 'package:expressed/models/transaction.dart';
import 'package:expressed/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  final Function updateTransaction;
  TransactionList({this.transactions, this.deleteTransaction, this.updateTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: transactions.isEmpty ? Text("No transaction!") :
            ListView.builder(
              itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return  TransactionCard(
                    title: transactions[index].title,
                    amount: transactions[index].amount,
                    dateTime: transactions[index].dateTime,
                    id: transactions[index].id,
                    deleteTransaction: deleteTransaction,
                    updateTransaction: updateTransaction,
                  );
              }),
    );
  }
}

