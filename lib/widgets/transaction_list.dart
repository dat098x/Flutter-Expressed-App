import 'package:expressed/models/transaction.dart';
import 'package:expressed/models/transaction_data.dart';
import 'package:expressed/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionData>(
      builder: (context, transactionData, index) {
          return Container(
            padding: EdgeInsets.all(20),
            child: transactionData.isEmty ? Text("No transaction!") :
            ListView.builder(
                itemCount: transactionData.transactionLength,
                itemBuilder: (context, index) {
                  final transaction = transactionData.transactions[index];
                  return  TransactionCard(
                    title: transaction.title,
                    amount: transaction.amount,
                    dateTime: transaction.dateTime,
                    id: transaction.id,
                    deleteTransactionCallback: () {
                        transactionData.deleteTransaction(transaction);
                    },
                  );
                }),
          );
      },
    );
  }
}

