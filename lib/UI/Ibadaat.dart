import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theummah/UI/homecomponent.dart';
import 'Namaz.dart';
import 'Ramadan.dart';

class Ibadaat extends StatelessWidget {
  const Ibadaat({
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
                Hero(
                  tag: 1,
                  child: MainCards(
                    text: 'Namaz',
                    images: 'assets/images/ic_ibadacolor.png',
                    nevigator: Namaz(),
                  ),
                ),
                MainCards(
                  text: 'Ramadan',
                  images: 'assets/images/ic_ramadancolor.png',
                  nevigator: Ramadan(),
                ),
              ],
            ),
          ],
        ),
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
                  radius: 40,
                  backgroundColor: Colors.green,
                  backgroundImage: AssetImage(images),
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
      ),
    );
  }
}
