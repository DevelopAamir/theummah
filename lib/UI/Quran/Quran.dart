import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theummah/Brain/db.dart';
import 'package:theummah/UI/Quran/quranview.dart';
import 'package:theummah/UI/homecomponent.dart';
import 'package:theummah/UI/viewpage.dart';

import '../Bookmark.dart';
import '../Gotoindex.dart';
import '../Pagewise.dart';
import '../Quranicdict.dart';
import '../Searchpage.dart';

class Quran extends StatefulWidget {
  const Quran({
    Key? key,
    required this.optionStyle,
  }) : super(key: key);

  final TextStyle optionStyle;

  @override
  State<Quran> createState() => _QuranState();
}

class _QuranState extends State<Quran> {
  @override
  void initState() {
    DB().initDB(dbName: 'PrayersTiming.db',tableName: 'timings').then((value){
      print(value.last.toString());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Timeandate(),
        Day(),
        Adhantime(),
        Expanded(
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 70),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Cardbuttons(
                          button: Quranview(),
                          image: 'assets/images/icqurancolor.png',

                          text: 'Read Quran',
                          texts: 'Last read:',
                          textss: 'Surah No 1,Ayat No 0\n6:12pm,10-Nov-2022',
                        ),
                        Cardbuttons(
                          button: PageWiseQuran(),
                          image: 'assets/images/icqurancolor.png',

                          text: 'Pagewise Quran',
                          texts: 'Last read:',
                          textss: 'Page:0',
                        ),
                        Cardbuttons(
                          button: SearchPage(),
                          image: 'assets/images/icsearchcolor.png',

                          text: 'Search in Quran',
                          texts: 'Advance search:',
                          textss: 'Search Word by word in\nNepali',
                        ),
                        Cardbuttons(
                          button: GotoIndex(),
                          image: 'assets/images/icgotocolor.png',
                          text: 'Go to Index',
                          texts: 'Index:',
                          textss: 'Search Ayat by Surah No\nAyat No.',
                        ),
                        const Cardbuttons(
                          button: BookMark(),
                          image: 'assets/images/icbookmarkscolor.png',
                          text: 'Bookmarks',
                          texts: "Saved ayat's:",
                          textss: 'Read all saved bookmarks',
                        ),
                        const Cardbuttons(
                          button: Quranicdictionary(),
                          image: 'assets/images/icdictcolor.png',
                          text: 'Quranic\nDictionary',
                          texts: 'Dictionary:',
                          textss: 'Meaning for the difficult',
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class Cardbuttons extends StatelessWidget {
  final String text;
  final String texts;
  final String textss;
  final String image;
  final Widget button;
  final colors;
  const Cardbuttons({
    Key? key,
    required this.text,
    required this.image,
    required this.button,
    required this.texts,
    required this.textss, this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return button;
        }));
      },
      child: Container(
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(33),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(11, 75, 15, 1.0),
                        Colors.green
                      ]
                  ),
                ),

                child: Image.asset(image,color:colors == null ? null :colors,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(texts,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic)),
                    Text(
                      textss,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                          fontSize: 12),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
