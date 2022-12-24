import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theummah/UI/Quran/campass.dart';
import 'package:theummah/UI/homecomponent.dart';

import 'Arrahiqul/Arrahikul.dart';
import 'Books.dart';
import 'Prayer/Adhannoti.dart';

class More extends StatelessWidget {
  const More({
    Key? key,
    required this.optionStyle,
  }) : super(key: key);

  final TextStyle optionStyle;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Timeandate(),
          const Day(),
          const Adhantime(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              MainCards(
                text: 'Prayer\nTimings',
                images: 'assets/images/ic_ibadacolor.png',
                nevigator: Adhan(),
              ),
              MainCards(
                text: 'Books',
                images: 'assets/images/ichadithyellow.png',
                nevigator: Books(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              MainCards(
                text: 'Compass',
                images: 'assets/images/qiblas.png',
                nevigator: Compass(),
              ),
              MainCards(
                text: 'Ar Rahequl\nMakhtoom',
                images: 'assets/images/ichadithcolor.png',
                nevigator: Arrahikul(),
              ),
            ],
          ),
        ],
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return nevigator;
          }));
        },
        child: Container(
          height: 165,
          width: 160,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
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
              children:[
               Expanded(child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Image.asset(images,),
               )),

                const SizedBox(height: 5),
                Text(
                  text,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
