import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:my_doctor/main.dart';

class AccountDaO{

   void updateUserAccountBalance(String amount) {
     Map<String, String> newValue = {
       "amount":amount,
     };
     accountRef.child(firebaseAuth.currentUser.uid).update(newValue);
  }

  Future<Future> creditAccount(String phone) async {
    Map userCredentials = {
      "phone": phone,
      "reference": firebaseAuth.currentUser.uid,
      "amount":"1"
    };
    String body = json.encode(userCredentials);
    final http.Response response = await http.post(
      Uri.parse("https://blooming-chamber-22698.herokuapp.com/v1/api/user/add-funds"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: body,
    );
    print("RESPONSE*********${response.body}");

    final jsonData = json.decode(response.body);
    return jsonData;
  }

}