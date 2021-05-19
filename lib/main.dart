import 'package:expressed/models/transaction_data.dart';
import 'package:expressed/screens/transaction_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: TransactionData(),
        child: MaterialApp(
          home: TransactionScreen(),
        ),
    );
  }
}


