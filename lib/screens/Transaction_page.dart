import 'package:flutter/material.dart';
import 'package:my_doctor/constant.dart';

class TransactionsPage extends StatefulWidget {
  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlueColor.withOpacity(0.5),
        title: Text("Transactions"),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.all(8),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.date_range,
                    size: 25,
                  ),
                  title: Text("Consultation Fee"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("12/03/2021"),
                      Text("Kes 200"),
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
            );
          }),
    );
  }
}
