import 'package:firebase_database/firebase_database.dart';
import 'package:my_doctor/models/Transaction.dart';

class TransactionsDaO {
  final DatabaseReference _transactionsRef = FirebaseDatabase.instance
      .reference()
      .child('transactions');

  void saveTransaction(Transaction transaction) {
    _transactionsRef.child(transaction.id).set(transaction.toJson());
  }

  Query getTransactions() {
    return _transactionsRef;
  }
}