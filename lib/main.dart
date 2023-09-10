import 'package:flutter/material.dart';
import 'package:phonebook/screens/phone_number_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone Number App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      home: PhoneNumberScreen(),
    );
  }
}

