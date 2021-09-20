import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:my_doctor/components/Divider.dart';
import 'package:my_doctor/components/category_card.dart';
import 'package:my_doctor/components/doctor_card.dart';
import 'package:my_doctor/components/search_bar.dart';
import 'package:my_doctor/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_doctor/controllers/DoctoctorsDaO.dart';
import 'package:my_doctor/main.dart';
import 'package:my_doctor/models/Account.dart';
import 'package:my_doctor/models/Doctor.dart';
import 'package:my_doctor/models/User.dart';
import 'package:my_doctor/screens/Transaction_page.dart';
import 'package:my_doctor/screens/consultation_history.dart';
import 'package:my_doctor/screens/profile_page.dart';
import 'package:my_doctor/utils/AlerDialog.dart';

class HomeScreen extends StatefulWidget {
  static const String idScreen = "home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  String balance = "0";
  Account userAccount;
  User user;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    loadUserAccount();
    fetchUserProfile();
    super.initState();
  }

  void loadUserAccount() async {
    accountRef
        .child(firebaseAuth.currentUser.uid)
        .once()
        .then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        setState(() {
          userAccount = new Account.fromSnapshot(dataSnapshot);
          balance = userAccount.amount;
        });
      } else {}
    });
  }

  void fetchUserProfile() async {
    userRef
        .child(firebaseAuth.currentUser.uid)
        .once()
        .then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        setState(() {
          user = new User.fromSnapshot(dataSnapshot);
        });
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    final doctorDao = DoctorDao();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: kBackgroundColor,
      drawer: Container(
        color: Colors.white,
        child: Drawer(
          child: ListView(
            children: [
              //Drawer Header
              Container(
                height: 165.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/profile.svg',
                        width: 65,
                        height: 65,
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user != null ? user.name : "Profile name",
                            style: TextStyle(fontSize: 14.0),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            user != null ? user.email : "Email address",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              AppDivider(),
              SizedBox(
                height: 12.0,
              ),
              //Drawer Body
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TransactionsPage()),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.history),
                  title: Text(
                    "Transaction history",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConsultationHistory()),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.history),
                  title: Text(
                    "Consultation history",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    "Visist Profile",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text(
                  "About",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ),
              GestureDetector(
                child: ListTile(
                  leading: Icon(Icons.lock),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                onTap: () {
                  showAlertDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      child: SvgPicture.asset('assets/icons/menu.svg'),
                      onTap: () {
                        scaffoldKey.currentState.openDrawer();
                      },
                    ),
                    Row(
                      children: [
                        Stack(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.notifications,
                                size: 35,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, left: 28),
                              child: CircleAvatar(
                                radius: 8,
                                backgroundColor: kOrangeColor,
                                child: Text(
                                  "5",
                                  style: TextStyle(
                                      color: kWhiteColor, fontSize: 8),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        SvgPicture.asset('assets/icons/profile.svg'),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kBlueColor.withOpacity(0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text(
                      "Current balance",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      "KES " + balance,
                      style: TextStyle(fontSize: 13),
                    ),
                    trailing: MaterialButton(
                      onPressed: () {},
                      color: kOrangeColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Quick deposit',
                        style: TextStyle(
                          color: kWhiteColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Find Your Desired\nDoctor',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: kTitleTextColor,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: SearchBar(),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kTitleTextColor,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              buildCategoryList(),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Doctors',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kTitleTextColor,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.75,
                child: FirebaseAnimatedList(
                  controller: _scrollController,
                  query: doctorDao.getDoctorsQuery(),
                  itemBuilder: (context, snapshot, animation, index) {
                    final json = snapshot.value as Map<dynamic, dynamic>;
                    final doctor = Doctor.fromJson(json);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: DoctorCard(
                        '${doctor.name}',
                        '${doctor.specialization} - ${doctor.hospital}',
                        '${doctor.image}',
                        kOrangeColor,
                        doctor.doctorId
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildCategoryList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 30,
          ),
          CategoryCard(
            'Dental\nSurgeon',
            'assets/icons/dental_surgeon.png',
            kBlueColor,
          ),
          SizedBox(
            width: 10,
          ),
          CategoryCard(
            'Heart\nSurgeon',
            'assets/icons/heart_surgeon.png',
            kYellowColor,
          ),
          SizedBox(
            width: 10,
          ),
          CategoryCard(
            'Eye\nSpecialist',
            'assets/icons/eye_specialist.png',
            kOrangeColor,
          ),
          SizedBox(
            width: 30,
          ),
        ],
      ),
    );
  }

}
