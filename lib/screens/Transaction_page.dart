import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:my_doctor/constant.dart';
import 'package:my_doctor/controllers/TransactionsDaO.dart';
import 'package:my_doctor/main.dart';
import 'package:my_doctor/models/Transaction.dart';

class TransactionsPage extends StatefulWidget {
  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final TransactionsDaO transactionsDaO = TransactionsDaO();
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlueColor.withOpacity(0.5),
        title: Text("Transactions"),
      ),
      body: FirebaseAnimatedList(
        controller: scrollController,
        query: transactionsDaO.getTransactions(),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final transaction = Transaction.fromJson(json);
          return transaction.userId.contains(firebaseAuth.currentUser.uid)
              ? Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.date_range,
                    size: 25,
                  ),
                  title: Text(transaction.description),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${transaction.date}"),
                      Text("Kes ${transaction.amount}"),
                    ],
                  ),
                  trailing: TextButton(
                    onPressed: () {},
                    child: Text("View"),
                  ),
                ),
                Divider(
                  thickness: 1.0,
                  indent: MediaQuery.of(context).size.width * 0.18,
                ),
              ],
            )
              : Container();
        },
      ),
    );
  }
}
