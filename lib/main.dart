import 'package:flutter/material.dart';
import 'package:tksmart/screen/home.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      title: 'Trakan Smart',
      home: Home(),
    );
  }
}
