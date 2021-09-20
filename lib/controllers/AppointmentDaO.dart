import 'package:firebase_database/firebase_database.dart';
import 'package:my_doctor/models/Appointment.dart';

class AppointmentDaO {
  final DatabaseReference _appointmentsRef = FirebaseDatabase.instance
      .reference()
      .child('appointments');

  void saveAppointment(Appointment appointment) {
    _appointmentsRef.child(appointment.id).set(appointment.toJson());
  }

  Query getAppointments() {
    return _appointmentsRef;
  }

   void closeAppointment(String appointmentId) {
     Map<String, String> newValue = {
       "status":"closed",
     };
     _appointmentsRef.child(appointmentId).update(newValue);
  }
}
