import 'package:flutter/material.dart';
import 'package:map_tutorial/home_screen.dart';
import 'package:map_tutorial/user_current_location.dart';

import 'convert_lating_to_address.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const GetUserCurrentLocatiionScreen(),
    );
  }
}

