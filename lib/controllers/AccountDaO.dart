import 'package:firebase_database/firebase_database.dart';
import 'package:my_doctor/main.dart';

class AccountDaO{
  final DatabaseReference _schedulesRef =
      FirebaseDatabase.instance.reference().child('accounts');

   void updateUserAccountBalance(String amount) {
     Map<String, String> newValue = {
       "amount":amount,
     };
     _schedulesRef.child(firebaseAuth.currentUser.uid).update(newValue);
  }

}