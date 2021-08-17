import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_doctor/main.dart';
import 'package:my_doctor/models/Account.dart';
import 'package:my_doctor/models/User.dart';

import '../constant.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  String balance = "0";
  Account userAccount;
  User user;

  @override
  void initState() {
    loadUserAccount();
    fetchUserProfile();
    super.initState();
  }

  void loadUserAccount() async {
    accountRef
        .child(firebaseAuth.currentUser.uid)
        .once()
        .then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        setState(() {
          userAccount = new Account.fromSnapshot(dataSnapshot);
          balance = userAccount.amount;
        });
      } else {}
    });
  }

  void fetchUserProfile() async {
    userRef
        .child(firebaseAuth.currentUser.uid)
        .once()
        .then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        setState(() {
          user = new User.fromSnapshot(dataSnapshot);
        });
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: kBlueColor.withOpacity(0.5),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user != null ? user.name : "Profile name",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          user != null ? user.email : "Email address",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Current Balance",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Ksh $balance",
                          style: TextStyle(fontSize: 16, color: Colors.indigo),
                        )
                      ],
                    ),
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                            child: Text(
                          "Add Funds",
                          style: TextStyle(fontSize: 12),
                        )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
