import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:my_doctor/components/schedule_card.dart';
import 'package:my_doctor/constant.dart';
import 'package:my_doctor/controllers/SceduleDaO.dart';
import 'package:my_doctor/main.dart';
import 'package:my_doctor/models/Schedule.dart';

class DoctorsSchedule extends StatefulWidget {
  @override
  _DoctorsScheduleState createState() => _DoctorsScheduleState();
}

class _DoctorsScheduleState extends State<DoctorsSchedule> {
  final scheduleDaO = ScheduleDao();
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: kOrangeColor,
        title: Text("Your Schedules"),
      ),
      body: FirebaseAnimatedList(
        controller: _scrollController,
        query:
            scheduleDaO.getDoctorSchedulesQuery(firebaseAuth.currentUser.uid),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final schedule = Schedule.fromJson(json);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ScheduleCard(
                schedule.name,
                schedule.description,
                schedule.date,
                schedule.month,
                kBlueColor,
                schedule.charge,
                schedule.status),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){

        },
      ),
    );
  }
}
