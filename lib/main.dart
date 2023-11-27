import 'package:flutter/material.dart';
import 'package:sukhingthan_mobile_code_test_23001/screens/tabbar_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TMDB Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TabbarScreen(),
    );
  }
}
