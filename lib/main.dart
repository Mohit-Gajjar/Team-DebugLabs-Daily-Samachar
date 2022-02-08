import 'package:flutter/material.dart';
import 'package:newapp/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My News',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home:const Home(),
    );
  }
}
