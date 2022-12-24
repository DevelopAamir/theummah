import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theummah/Brain/db.dart';
import 'package:theummah/UI/Quran/Card/ayat.dart';
import 'package:theummah/UI/Quran/para.dart';
import 'package:theummah/UI/Quran/readQuranPage.dart';
import 'package:theummah/UI/viewpage.dart';

class Quranview extends StatefulWidget {
  const Quranview({Key? key}) : super(key: key);

  @override
  State<Quranview> createState() => _QuranviewState();
}

class _QuranviewState extends State<Quranview> {
  var data;
  var surah;
  var language = 'ayat_nepali';
  var parah;

  @override
  void initState() {

    DB()
        .initDB(dbName: 'Qurannepali.db', tableName: 'surahnames')
        .then((value) {
      setState(() {
        data = value;
      });
    });
    DB().initDB(dbName: 'Qurannepali.db',tableName: 'nepaliquran').then((value){
      setState(() {

        surah = value;
      });

    });
    DB()
        .initDB(dbName: 'Surahnames.db', tableName: 'paranames')
        .then((value) {
      setState(() {
        parah = value;
      });
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            width: 130,
            child: const TabBar(labelPadding: EdgeInsets.zero, tabs: [
              Tab(
                text: 'Surah',
              ),
              Tab(
                text: 'Parah',
              ),
            ]),
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Last Seen:',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Text(
                    'Surah: Al-Fatiha Ayat:1:0:',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                  Expanded(
                      child: data == null
                          ? Container(
                            child: Center(
                              child: CircularProgressIndicator(
                                  color: Colors.indigo,
                                ),
                            ),
                          )
                          : ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Cardbuttonss(
                                  button: (){
                                    List<AayatCard> particularSurah = [];

                                    for(var s in surah){
                                      if(s['surah_no'] == data[index]['surah_id']){
                                        setState(() {
                                          particularSurah.add(AayatCard(data: s,language: language,));
                                        });

                                      }
                                    }
                                    print(particularSurah[0].data.toString());
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return ReadQuran(data: particularSurah,title: data[index]['surah_name']);
                                    }));
                                  },
                                  image: 'assets/bg.jpg',
                                  text: data[index]['surah_name'],
                                  texts: '',
                                  textss: data[index]['surah_arabic'],
                                );
                              }))
                ],
              ),
              color: Colors.white,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Last Seen:',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Text(
                    'Para: Al-Fatiha Ayat:1:0:',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                  Expanded(child:parah == null? Container():  ListView.builder(
                    itemCount: parah.length,
                    itemBuilder: (context,i){
                      return  Cardbuttonss(
                        button: (){
                          List<AayatCard> particularSurah = [];

                          for(var s in surah){
                            if(s['para_ID'] == parah[i]['para_id']){
                              setState(() {
                                particularSurah.add(AayatCard(data: s,language: language,));
                              });

                            }
                          }
                        //  print(particularSurah[0].data.toString());
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ReadQuran(data: particularSurah,title: parah[i]['para_name_arabic']);
                          }));
                        },
                        image: 'assets/bg.jpg',
                        text: parah[i]['para_name_arabic'].toString(),
                        texts: '',
                        textss: parah[i]['para_name_nepali'].toString(),
                      );
                    }))

                ],
              ),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class Cardbuttonss extends StatelessWidget {
  final String text;
  final String texts;
  final String textss;
  final String image;
  final Function()? button;
  const Cardbuttonss({
    Key? key,
    required this.text,
    required this.image,
    required this.button,
    required this.texts,
    required this.textss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: button,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '1',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Colors.black),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text(
                    texts,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
            Text(
              textss,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 18),
            ),
            SizedBox(
              width: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 100,
                  width: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ViewPage();
                          },
                        ),
                      );
                    },
                    child:const Icon(Icons.arrow_drop_down_circle_sharp),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
