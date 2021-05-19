import 'package:expressed/models/transaction_data.dart';
import 'package:expressed/screens/update_transaction_screen.dart';
import 'package:expressed/widgets/chart.dart';
import 'package:expressed/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  bool _showChart = false;

  AppBar appBar = AppBar(
    title: Text('Expressed'),
  );

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final chartHeight = isLandscape ? 0.7 : 0.3;
    if (!isLandscape) _showChart = true;

    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(context: context, builder: (context) => UpdateTransaction());
        },
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(isLandscape) Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart'),
                  Switch(value: _showChart, onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  })
                ],
              ),
              if(_showChart)  Container(
                  height:  (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *  chartHeight
                  ,
                  child: Chart(Provider.of<TransactionData>(context).recentTransactions)),
              Expanded(
                child: TransactionList()
              ),
            ],
          ),
        ),
      ),
    );
  }
}
