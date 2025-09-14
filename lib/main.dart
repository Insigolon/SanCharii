import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; //Firebase
import 'app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //Initialize Firebase
  runApp(const MyApp()); //  Call your root widget here
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.splash, //starts from splash screen
    );
  }
}
//get sleep instead of staying up and ruining your memory. So many comments who writes  