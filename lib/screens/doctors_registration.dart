import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_doctor/constant.dart';
import 'package:my_doctor/main.dart';

class DoctorsRegistration extends StatefulWidget {
  @override
  _DoctorsRegistrationState createState() => _DoctorsRegistrationState();
}

class _DoctorsRegistrationState extends State<DoctorsRegistration> {
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final nameEditingController = TextEditingController();
  final hospitalEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final specializationEditingController = TextEditingController();
  final aboutEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kOrangeColor,
        title: Text("Doctors Registration", style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
       body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Colors.grey,
                      ),
                      Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 1.0,
                      ),
                      TextField(
                        controller: emailEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(fontSize: 14.0),
                          hintStyle:
                              TextStyle(fontSize: 10.0, color: Colors.grey),
                        ),
                        style: TextStyle(fontSize: 14.0),
                      ),
                       SizedBox(
                        height: 1.0,
                      ),
                      TextField(
                        obscureText: true,
                        controller: passwordEditingController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(fontSize: 14.0),
                          hintStyle:
                              TextStyle(fontSize: 10.0, color: Colors.grey),
                        ),
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 1.0,
                      ),
                      TextField(
                        controller: nameEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(fontSize: 14.0),
                          hintStyle:
                              TextStyle(fontSize: 10.0, color: Colors.grey),
                        ),
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 1.0,
                      ),
                      TextField(
                        controller: hospitalEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Hospital',
                          labelStyle: TextStyle(fontSize: 14.0),
                          hintStyle:
                              TextStyle(fontSize: 10.0, color: Colors.grey),
                        ),
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 1.0,
                      ),
                      TextField(
                        controller: phoneEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          labelStyle: TextStyle(fontSize: 14.0),
                          hintStyle:
                              TextStyle(fontSize: 10.0, color: Colors.grey),
                        ),
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 1.0,
                      ),
                      TextField(
                        controller: specializationEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Specialization',
                          labelStyle: TextStyle(fontSize: 14.0),
                          hintStyle:
                              TextStyle(fontSize: 10.0, color: Colors.grey),
                        ),
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 1.0,
                      ),
                      TextField(
                        controller: aboutEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'About',
                          labelStyle: TextStyle(fontSize: 14.0),
                          hintStyle:
                              TextStyle(fontSize: 10.0, color: Colors.grey),
                        ),
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      MaterialButton(
                        onPressed: () {
                          
                        },
                        color: kOrangeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: Center(
                            child: Text(
                              'Create account',
                              style: TextStyle(
                                color: kWhiteColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void registerNewUser(BuildContext context) async {
  //   loader.showDialogue("Registering please wait...");
  //   try {
  //     final User user = (await firebaseAuth.createUserWithEmailAndPassword(
  //             email: emailEditingController.text, password: passwordEditingController.text))
  //         .user;
  //     //saving user data to Firebase Database

  //     Map doctorDataMap = {
  //       "id": user.uid,
  //       "name": nameController.text.trim(),
  //       "email": emailController.text.trim(),
  //       "phone": phoneController.text.trim(),
  //       "nationalId": idController.text.trim(),
  //       "image": ""
  //     };

  //     Map accountDataMap = {"id": user.uid, "amount": "0", "type": "doctor"};

  //     doctorsRef.child(user.uid).set(doctorDataMap);
  //     accountRef.child(user.uid).set(accountDataMap);

  //     displayToastMessage(context,
  //         "Congratulations! your account has been created successfully");

  //     Navigator.pushNamedAndRemoveUntil(
  //         context, HomeScreen.idScreen, (route) => false);
  //   } catch (e) {
  //     loader.hideDialogue();
  //     displayToastMessage(context, "Error: " + e.toString());
  //   }
  // }
}