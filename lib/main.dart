import 'package:my_doctor/screens/home_screen.dart';
import 'package:my_doctor/screens/login.dart';
import 'package:my_doctor/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_doctor/screens/registration.dart';

void main() => runApp(MyApp());

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
