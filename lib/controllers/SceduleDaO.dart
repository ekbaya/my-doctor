import 'package:firebase_database/firebase_database.dart';

class ScheduleDao {
  final DatabaseReference _doctorsRef =
      FirebaseDatabase.instance.reference().child('scheduls');

  Query getDoctorSchedulesQuery(String doctorId) {
    return _doctorsRef.child(doctorId);
  }
}