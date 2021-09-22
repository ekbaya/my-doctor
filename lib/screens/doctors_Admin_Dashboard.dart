import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:my_doctor/components/schedule_card.dart';
import 'package:my_doctor/constant.dart';
import 'package:my_doctor/controllers/SceduleDaO.dart';
import 'package:my_doctor/main.dart';
import 'package:my_doctor/models/Schedule.dart';
import 'package:my_doctor/screens/doctors_appointments.dart';
import 'package:my_doctor/screens/doctors_schedule.dart';
import 'package:my_doctor/utils/AlerDialog.dart';

class DoctorsAdminDashboard extends StatefulWidget {
  static const String idScreen = "dashboard";

  @override
  _DoctorsAdminDashboardState createState() => _DoctorsAdminDashboardState();
}

class _DoctorsAdminDashboardState extends State<DoctorsAdminDashboard> {
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final scheduleDaO = ScheduleDao();
    return Scaffold(
      backgroundColor: Colors.teal[200],
      appBar: AppBar(
        backgroundColor: kOrangeColor,
        title: Text("Doctors Dashboard"),
        elevation: 0.5,
        actions: [
          TextButton(onPressed: (){
            showAlertDialog(context);
          }, child: Text("Logout", style: TextStyle(color: Colors.white),)),
          SizedBox(width: 20,)
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DoctorsSchedule()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.calendar_today),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Scedules",
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DoctorsAppointments()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_view_day,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Apponitments",
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.person),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Profile",
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Upcoming Events",
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: FirebaseAnimatedList(
                controller: _scrollController,
                query: scheduleDaO
                    .getDoctorSchedulesQuery(firebaseAuth.currentUser.uid),
                itemBuilder: (context, snapshot, animation, index) {
                  final json = snapshot.value as Map<dynamic, dynamic>;
                  final schedule = Schedule.fromJson(json);
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: ScheduleCard(
                        schedule.name,
                        schedule.description,
                        schedule.date,
                        schedule.month,
                        kWhiteColor,
                        schedule.charge,
                        schedule.status),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
