import 'package:flutter/material.dart';
import 'screen/homescreen.dart';
void main() {
  runApp(HistorySnapApp());
}

class HistorySnapApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'History Snap!',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomeScreen(),
    );
  }
}


