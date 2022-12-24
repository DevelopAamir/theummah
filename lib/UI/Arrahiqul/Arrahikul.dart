import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Arrahiqulview.dart';

class Arrahikul extends StatelessWidget {
  const Arrahikul({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ar-Raheeq-Al-Makhtum'),
      ),
      body: MainCards(
        images: 'assets/pic.jpg',
        nevigator: View(),
        text: 'Aa Raheeul\nMakhtoom\n(English)',
      ),
    );
  }
}

class MainCards extends StatelessWidget {
  final String text;
  final String images;
  final Widget nevigator;
  const MainCards({
    Key? key,
    required this.text,
    required this.images,
    required this.nevigator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return nevigator;
        }));
      },
      child: Container(
        height: 200,
        width: 145,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 38,
                backgroundColor: Colors.green,
                backgroundImage: AssetImage(images),
              ),
              SizedBox(height: 5),
              Text(
                text,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
