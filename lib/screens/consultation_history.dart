import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:my_doctor/controllers/AppointmentDaO.dart';
import 'package:my_doctor/controllers/SceduleDaO.dart';
import 'package:my_doctor/main.dart';
import 'package:my_doctor/models/Appointment.dart';

import '../constant.dart';

class ConsultationHistory extends StatefulWidget {
  @override
  _ConsultationHistoryState createState() => _ConsultationHistoryState();
}

class _ConsultationHistoryState extends State<ConsultationHistory> {
  final AppointmentDaO appointmentDaO = AppointmentDaO();
  final ScheduleDao scheduleDao = ScheduleDao();
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBlueColor.withOpacity(0.5),
          title: Text("Appointments"),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Open",
              ),
              Tab(
                text: "Closed",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            //Open Apponitments
            FirebaseAnimatedList(
              controller: _scrollController,
              query: appointmentDaO.getAppointments(),
              itemBuilder: (context, snapshot, animation, index) {
                final json = snapshot.value as Map<dynamic, dynamic>;
                final appointment = Appointment.fromJson(json);
                return appointment.userId
                            .contains(firebaseAuth.currentUser.uid) &&
                        appointment.status.contains("open")
                    ? Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.calendar_view_day,
                              size: 25,
                            ),
                            title: Text(appointment.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(appointment.description),
                                Text(appointment.doctorName),
                              ],
                            ),
                            trailing: TextButton(
                              onPressed: () async{
                                appointmentDaO.closeAppointment(appointment.id);
                                scheduleDao.releaseSchedule(
                                    appointment.doctorId,
                                    appointment.scheduleId);
                              },
                              child: Text("Cancel"),
                            ),
                          ),
                          Divider(
                            thickness: 1.0,
                            indent: MediaQuery.of(context).size.width * 0.18,
                          ),
                        ],
                      )
                    : Container();
              },
            ),

            //Closed Appointments
            FirebaseAnimatedList(
              controller: _scrollController,
              query: appointmentDaO.getAppointments(),
              itemBuilder: (context, snapshot, animation, index) {
                final json = snapshot.value as Map<dynamic, dynamic>;
                final appointment = Appointment.fromJson(json);
                return appointment.userId
                            .contains(firebaseAuth.currentUser.uid) &&
                        appointment.status.contains("closed")
                    ? Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.calendar_view_day,
                              size: 25,
                            ),
                            title: Text(appointment.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(appointment.description),
                                Text(appointment.doctorName),
                              ],
                            ),
                            trailing: TextButton(
                              onPressed: () {},
                              child: Text('${appointment.day}th ${appointment.month} ${appointment.year}'),
                            ),
                          ),
                          Divider(
                            thickness: 1.0,
                            indent: MediaQuery.of(context).size.width * 0.18,
                          ),
                        ],
                      )
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
