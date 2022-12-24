import 'package:flutter/material.dart';
import 'package:theummah/UI/Albukhari/bulugh.dart';
import 'package:theummah/UI/homecomponent.dart';

import 'bukhariview.dart';

class Hadith extends StatelessWidget {
  const Hadith({
    Key? key,
    required this.optionStyle,
  }) : super(key: key);

  final TextStyle optionStyle;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Timeandate(),
            Day(),
            Adhantime(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                MiniCard(
                  text: 'Al Bukhari',
                  image: 'assets/images/ichadithcolor.png',
                  navigate: BukhariView(),
                ),
                MiniCard(
                  text: 'Bulugh Al\n Maram',
                  image: 'assets/images/ichadithyellow.png',
                  navigate: Bulugh(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MiniCard extends StatelessWidget {
  final String image;
  final Widget navigate;
  final String text;
  const MiniCard({
    Key? key,
    required this.text,
    required this.image,
    required this.navigate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return navigate;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(

                radius: 40,
                backgroundColor: Colors.green,
                backgroundImage: AssetImage(image),
              ),
              SizedBox(height: 5),
              Text(
                text,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
