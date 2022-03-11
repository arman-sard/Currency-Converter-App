import 'package:currency_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    // ignore: prefer_const_constructors
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.grey[300],
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
