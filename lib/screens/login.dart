import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_doctor/models/Account.dart';
import 'package:my_doctor/screens/home_screen.dart';
import 'package:my_doctor/screens/registration.dart';
import 'package:my_doctor/utils/Loader.dart';
import 'package:my_doctor/utils/MainAppToast.dart';

import '../constant.dart';
import '../main.dart';

class LoginScreen extends StatefulWidget {
  static const String idScreen = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailEditingController = TextEditingController();

  final passwordEditingController = TextEditingController();

  Loader loader;

  Account userAccount;

  void loadUserAccount() async {
    accountRef
        .child(firebaseAuth.currentUser.uid)
        .once()
        .then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        setState(() {
          userAccount = new Account.fromSnapshot(dataSnapshot);
        });
        if(userAccount.type.contains("user")){
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.idScreen, (route) => false);
        }else{}
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    loader = Loader(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Colors.grey,
                      ),
                      Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 1.0,
                      ),
                      TextField(
                        controller: emailEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(fontSize: 14.0),
                          hintStyle:
                              TextStyle(fontSize: 10.0, color: Colors.grey),
                        ),
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 1.0,
                      ),
                      TextField(
                        controller: passwordEditingController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(fontSize: 14.0),
                          hintStyle:
                              TextStyle(fontSize: 10.0, color: Colors.grey),
                        ),
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      MaterialButton(
                        onPressed: () {
                          if (!emailEditingController.text.contains("@")) {
                          displayToastMessage(
                              context, "Email address is not valid.");
                        } else if (passwordEditingController.text.isEmpty) {
                          displayToastMessage(context, "Password is required.");
                        } else {
                          loginUser(context);
                        }
                        },
                        color: kOrangeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: kWhiteColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RegistrationScreen.idScreen, (route) => false);
                  },
                  child: Text(
                    "Do not have an Account? Register Here.",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginUser(BuildContext context) async {
    loader.showDialogue("Signing in please wait...");
    try {
      final User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: emailEditingController.text,
              password: passwordEditingController.text))
          .user;
      //check if we have user's data in our database
      userRef
          .child(user.uid)
          .once()
          .then((DataSnapshot dataSnapshot) {
                if (dataSnapshot.value != null) {
                  displayToastMessage(
                      context, "You have been logged in successfully");
                  loadUserAccount();

                } else {
                  loader.hideDialogue();
                  firebaseAuth.signOut();
                  displayToastMessage(context,
                      "No record exist for this user, please create new account");
                }
              });
    } catch (e) {
      loader.hideDialogue();
      displayToastMessage(context, "Error: " + e.toString());
    }
  }
}
