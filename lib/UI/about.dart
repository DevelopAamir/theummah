import 'package:flutter/material.dart';

class Aboutpage extends StatelessWidget {
  const Aboutpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'About App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'The Ummah android appis developed to make All kinds of islamic book easily accessible through phones in Nepali Language nThis app is published by ZS Studio. More feature will be added shortly ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'The Ummah android appis developed to make All kinds of islamic book easily accessible.',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Gmail: amir@gmail.com',
              style: TextStyle(
                color: Colors.purple,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
