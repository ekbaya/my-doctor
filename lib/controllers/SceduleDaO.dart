import 'package:firebase_database/firebase_database.dart';

class ScheduleDao {
  final DatabaseReference _schedulesRef =
      FirebaseDatabase.instance.reference().child('scheduls');

  Query getDoctorSchedulesQuery(String doctorId) {
    return _schedulesRef.child(doctorId);
  }

   void markScheduleAsBooked(String doctorId, String scheduleId) {
     Map<String, String> newValue = {
       "status":"booked",
     };
     _schedulesRef.child(doctorId).child(scheduleId).update(newValue);
  }

  void releaseSchedule(String doctorId, String scheduleId) {
    print("HERE*******${doctorId}************${scheduleId}****");
     Map<String, String> newValue = {
       "status":"open",
     };
     _schedulesRef.child(doctorId).child(scheduleId).update(newValue);
  }
}