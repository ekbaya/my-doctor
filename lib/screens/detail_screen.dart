import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:my_doctor/components/schedule_card.dart';
import 'package:my_doctor/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_doctor/controllers/AccountDaO.dart';
import 'package:my_doctor/controllers/AppointmentDaO.dart';
import 'package:my_doctor/controllers/SceduleDaO.dart';
import 'package:my_doctor/controllers/TransactionsDaO.dart';
import 'package:my_doctor/main.dart';
import 'package:my_doctor/models/Account.dart';
import 'package:my_doctor/models/Appointment.dart';
import 'package:my_doctor/models/Schedule.dart';
import 'package:my_doctor/models/Transaction.dart';
import 'package:my_doctor/utils/Loader.dart';
import 'package:my_doctor/utils/MainAppToast.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  var _name;
  var _description;
  var _imageUrl;
  var doctor_id;

  DetailScreen(this._name, this._description, this._imageUrl, this.doctor_id);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  ScrollController _scrollController = ScrollController();
  int selectedIndex = -1;
  Schedule selectedSchedule;
  Account account;

  @override
  void initState() {
    loadUserAccount();
    super.initState();
  }

  void loadUserAccount() async {
    accountRef
        .child(firebaseAuth.currentUser.uid)
        .once()
        .then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        setState(() {
          account = new Account.fromSnapshot(dataSnapshot);
        });
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScheduleDao scheduleDao = ScheduleDao();
    final AppointmentDaO appointmentDaO = AppointmentDaO();
    final AccountDaO accountDaO = AccountDaO();
    final TransactionsDaO transactionsDaO = TransactionsDaO();
    Loader loader = Loader(context);

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/detail_illustration.png'),
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        'assets/icons/back.svg',
                        height: 18,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/icons/3dots.svg',
                      height: 18,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.24,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.network(
                            widget._imageUrl,
                            height: 120,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget._name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: kTitleTextColor,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget._description,
                                style: TextStyle(
                                    color: kTitleTextColor.withOpacity(0.7),
                                    fontSize: 12),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: kBlueColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/phone.svg',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: kYellowColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/chat.svg',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: kOrangeColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/video.svg',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'About Doctor',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kTitleTextColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${widget._name} is the top most heart surgeon in Flower\nHospital. She has done over 100 successful sugeries\nwithin past 3 years. She has achieved several\nawards for her wonderful contribution in her own\nfield. She’s available for private consultation for\ngiven schedules.',
                        style: TextStyle(
                          height: 1.6,
                          color: kTitleTextColor.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Doctor\'s Schedules',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kTitleTextColor,
                        ),
                      ),
                      Container(
                        height: 500,
                        width: MediaQuery.of(context).size.width,
                        child: FirebaseAnimatedList(
                          controller: _scrollController,
                          query: scheduleDao
                              .getDoctorSchedulesQuery(widget.doctor_id),
                          itemBuilder: (context, snapshot, animation, index) {
                            final json =
                                snapshot.value as Map<dynamic, dynamic>;
                            final schedule = Schedule.fromJson(json);
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: GestureDetector(
                                onTap: () {
                                  if (!schedule.status.contains("booked")) {
                                    setState(() {
                                      selectedIndex = index;
                                      selectedSchedule = schedule;
                                    });
                                  }
                                },
                                child: ScheduleCard(
                                    schedule.name,
                                    schedule.description,
                                    schedule.date,
                                    schedule.month,
                                    selectedIndex == index
                                        ? kOrangeColor
                                        : kBlueColor,
                                    schedule.charge,
                                    schedule.status),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (selectedSchedule == null) {
            displayToastMessage(context, "Please select a schedule to book");
          } else {
            if (int.parse(account.amount) <
                int.parse(selectedSchedule.charge)) {
              displayToastMessage(context,
                  "You have Insufficient funds please load your account");
            } else {
              String timestamp =
                  DateTime.now().millisecondsSinceEpoch.toString();
              final DateTime now = DateTime.now();
              final DateFormat formatter = DateFormat('yyyy-MM-dd');
              final String formatted = formatter.format(now);
              Appointment appointment = Appointment(
                  day: selectedSchedule.date,
                  month: selectedSchedule.month,
                  year: selectedSchedule.year,
                  description: selectedSchedule.description,
                  charge: selectedSchedule.charge,
                  name: selectedSchedule.name,
                  status: selectedSchedule.status,
                  id: timestamp,
                  doctorId: widget.doctor_id,
                  userId: firebaseAuth.currentUser.uid,
                  scheduleId: selectedSchedule.scheduleID,
                  doctorName: widget._name);
              displayToastMessage(context, "Booking...");
              appointmentDaO.saveAppointment(appointment);
              scheduleDao.markScheduleAsBooked(
                  widget.doctor_id, selectedSchedule.scheduleID);
              String newBalance =
                  (int.parse(account.amount) - int.parse(appointment.charge))
                      .toString();
              accountDaO.updateUserAccountBalance(newBalance);
              Transaction transaction = Transaction(
                  description: selectedSchedule.name,
                  id: timestamp,
                  date: formatted,
                  refrence: timestamp,
                  userId: firebaseAuth.currentUser.uid,
                  amount: selectedSchedule.charge);
              transactionsDaO.saveTransaction(transaction);
              loadUserAccount();
              displayToastMessage(context, "Success");
              setState(() {
                selectedSchedule = null;
                selectedIndex = -1;
              });
            }
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 45,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Text(
              "Book Appointment",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
