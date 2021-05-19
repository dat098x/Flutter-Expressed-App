import 'package:expressed/models/transaction_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/transaction.dart';

class UpdateTransaction extends StatefulWidget {
  String id;
  String title;
  double amount;
  DateTime date;
  UpdateTransaction({this.id, this.amount, this.title, this.date});

  @override
  _UpdateTransactionState createState() => _UpdateTransactionState();
}

class _UpdateTransactionState extends State<UpdateTransaction> {
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  DateTime _selectedDate;
  bool isAdd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.title;
    amountController.text = widget.amount == null ? ''.toString() : widget.amount.toString();
    isAdd = widget.id == null;
    setState(() {
      _selectedDate = widget.date;
    });
  }
  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = amountController.text == '' ? 0.0 : double.parse(amountController.text);

    if (enteredTitle == null || enteredAmount <= 0 || _selectedDate == null ) {
      return null;
    }

    if ( isAdd) {
      final newTransaction = Transaction(
          id: DateTime.now().toString(),
          title: enteredTitle,
          amount: enteredAmount,
          dateTime: _selectedDate);
      Provider.of<TransactionData>(context, listen: false).addTransaction(newTransaction);
    } else {
      final updateTransaction = Transaction(
          id: widget.id,
          title: enteredTitle,
          amount: enteredAmount,
          dateTime: _selectedDate);
      Provider.of<TransactionData>(context, listen: false).updateTransaction(updateTransaction);
    }

    Navigator.pop(context);
  }

  void _presentDatePicker() {
    showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });

    });

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          right: 10,
          left: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Input your transaction'
              ),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Input your amount'
              ),
            ),
            Row(
              children: [
                Text(_selectedDate == null ? 'No Date Chosen!' : DateFormat.yMd().format(_selectedDate)),
                SizedBox(
                  width: 10,
                ),
                TextButton(onPressed: _presentDatePicker,
                    child: Text('Choose Date',
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    )
                )
              ],
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
              ),
              child: Text(isAdd ? 'Add' : 'Update',
                style: TextStyle(color: Colors.white),
              ),
                onPressed: () {
                  submitData();
                }
            )
          ],
        ),
      ),
    );
  }
}
