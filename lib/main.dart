import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:my_doctor/screens/home_screen.dart';
import 'package:my_doctor/screens/login.dart';
import 'package:my_doctor/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_doctor/screens/registration.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MpesaFlutterPlugin.setConsumerKey("HR28DI2GWXa3Zn550f9dB2HyXKCTerw7");
  MpesaFlutterPlugin.setConsumerSecret("zU4wGQ4S3e10ahCl");
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference userRef = FirebaseDatabase.instance.reference().child("users");
DatabaseReference accountRef = FirebaseDatabase.instance.reference().child("accounts");
DatabaseReference categoriesRef = FirebaseDatabase.instance.reference().child("categories");
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme:
            GoogleFonts.varelaRoundTextTheme(Theme.of(context).textTheme),
      ),
      initialRoute: OnboardingScreen.idScreen,
      routes: {
        RegistrationScreen.idScreen: (context)=> RegistrationScreen(),
        LoginScreen.idScreen: (context)=> LoginScreen(),
        HomeScreen.idScreen: (context)=> HomeScreen(),
        OnboardingScreen.idScreen: (context)=> OnboardingScreen(),
      },
    );
  }
}
