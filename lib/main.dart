import 'package:flutter/material.dart';

import 'View/login_view.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: Home()
      home:LoginView()
    );
  }
}

