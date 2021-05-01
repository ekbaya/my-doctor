import 'package:flutter/material.dart';
import 'package:my_doctor/main.dart';
import 'package:my_doctor/screens/onboarding_screen.dart';

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = FlatButton(
      child: Text("CANCEL"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      });
  Widget continueButton = FlatButton(
    child: Text("YES"),
    onPressed: () async {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      firebaseAuth.signOut();
      Navigator.pushNamedAndRemoveUntil(
          context, OnboardingScreen.idScreen, (route) => false);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Attention !!!"),
    content: Text("Are you sure you want to sign out ?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
