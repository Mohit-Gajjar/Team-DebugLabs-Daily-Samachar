import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About Us",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: const [
            Image(width: 100, image: AssetImage('assets/logo.png')),
            SizedBox(
              height: 10,
            ),
            Text(
              "Developed at",
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Team DebugLabs"),
            SizedBox(
              height: 10,
            ),
            Text("Contact: debuglabs.io@gmail.com"),
             SizedBox(
              height: 10,
            ),
            Text("Special thanks to: Mohit Gajjar")
          ],
        ),
      ),
    );
  }
}
