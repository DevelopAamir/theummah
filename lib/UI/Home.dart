import 'package:flutter/material.dart';
import 'package:theummah/Brain/Notification_Services.dart';
import 'package:theummah/Brain/getData.dart';

import 'homecomponent.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
    required this.optionStyle,
  }) : super(key: key);

  final TextStyle optionStyle;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Ourpost> data = [];
  @override
  void initState() {
    GetData().getPosts().then((value){
      setState(() {
        data = value;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Timeandate(),
             Day(),
             Adhantime(),
             Hero(tag: 1, child: SearchBar()),
            Builder(builder: (context)=> Column(
              children: data
            )),

             AyatOfTheMoment(),
             Adhannotification(),
             Readbook(),
             Whatsnew(),
          ],
        ),
      ),
    );
  }
}
