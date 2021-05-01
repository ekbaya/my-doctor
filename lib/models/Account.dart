import 'package:firebase_database/firebase_database.dart';

class Account{
  String id, amount, type;
  Account({this.id, this.amount, this.type});

  factory Account.fromSnapshot(DataSnapshot snapshot)=>accountFromSnapshot(snapshot);
}

Account accountFromSnapshot(DataSnapshot snapshot){
  return Account(
    id: snapshot.value['id'],
    amount: snapshot.value['amount'],
    type: snapshot.value['type'],
  );
}