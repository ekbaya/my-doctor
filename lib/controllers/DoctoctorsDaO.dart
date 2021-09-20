import 'package:firebase_database/firebase_database.dart';

class DoctorDao {
  final DatabaseReference _doctorsRef =
      FirebaseDatabase.instance.reference().child('doctors');

  Query getDoctorsQuery() {
    return _doctorsRef;
  }
}
