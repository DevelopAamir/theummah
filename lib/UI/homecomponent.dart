import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:theummah/Brain/Notification_Services.dart';
import 'package:theummah/Brain/db.dart';
import 'package:theummah/UI/Books.dart';
import 'package:theummah/UI/Quran/campass.dart';
import 'Prayer/Adhannoti.dart';
import 'Readbook.dart';
import 'Searchpage.dart';

class Timeandate extends StatefulWidget {
  const Timeandate({
    Key? key,

  }) : super(key: key);



  @override
  State<Timeandate> createState() => _TimeandateState();
}

class _TimeandateState extends State<Timeandate> {
  var date = DateTime.now();
  var data;
  var timingNow = '';
  var namazTime = '';
  var next = '';
  @override
  void initState() {
    DB().initDB(dbName: 'PrayersTiming.db', tableName: 'timings').then((value) {
      setState(() {
        data = value;
      });
      for (var v in value) {
        print(v.toString());
        if (v['cityid'] == 1 &&
            v['date'].toString() ==
                DateFormat('dd-MM-yyyy').format(date).toString()) {
          setState(() {
            timingNow = v['date'];
          });

          if (int.parse(v['dhuhr'].toString().split(':').first) >=
                  DateTime.now().hour &&
              DateTime.now().hour >=
                  int.parse(v['fajr'].toString().split(':').first)) {
            setState(() {
              timingNow = 'fajr';
              namazTime = v['fajr'];
            });
          } else if (int.parse(v['asr'].toString().split(':').first) >=
                  DateTime.now().hour &&
              DateTime.now().hour >=
                  int.parse(v['dhuhr'].toString().split(':').first)) {
            setState(() {
              timingNow = 'dhuhr';
              namazTime = v['dhuhr'];
            });
          } else if (int.parse(v['maghrib'].toString().split(':').first) >=
                  DateTime.now().hour &&
              DateTime.now().hour >=
                  int.parse(v['asr'].toString().split(':').first)) {
            setState(() {
              timingNow = 'asr';
              namazTime = v['asr'];
            });
          } else if (int.parse(v['isha'].toString().split(':').first) >=
                  DateTime.now().hour &&
              DateTime.now().hour >=
                  int.parse(v['maghrib'].toString().split(':').first)) {
            setState(() {
              timingNow = 'maghrib';
              namazTime = v['maghrib'];
            });
          } else if (DateTime.now().hour >=
              int.parse(v['isha'].toString().split(':').first)) {
            setState(() {
              timingNow = 'isha';
              namazTime = v['isha'];
            });
          } else {
            print({
              int.parse(v['dhuhr'].toString().split(':').first) >
                      DateTime.now().hour &&
                  DateTime.now().hour <
                      int.parse(v['fajr'].toString().split(':').first)
            }.toString());
            print({
              int.parse(v['asr'].toString().split(':').first) >
                      DateTime.now().hour &&
                  DateTime.now().hour <
                      int.parse(v['dhuhr'].toString().split(':').first)
            }.toString());
            print({
              int.parse(v['maghrib'].toString().split(':').first) >
                      DateTime.now().hour &&
                  DateTime.now().hour <
                      int.parse(v['asr'].toString().split(':').first)
            }.toString());
            print({
              int.parse(v['isha'].toString().split(':').first) >
                      DateTime.now().hour &&
                  DateTime.now().hour >
                      int.parse(v['maghrib'].toString().split(':').first)
            }.toString());
            print({
              DateTime.now().hour.toString()
                  + v['isha'].toString().split(':').first
            }.toString());
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Icon(
            Icons.timelapse,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            timingNow.toString(),
            style: const TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            namazTime != ''
                ? int.parse(namazTime.split(':').first) > 12
                    ? '${int.parse(namazTime.split(':').first) - 12}' +
                        ':' +
                        namazTime.split(':').first +
                        ' pm'
                    : namazTime.split(':').first +
                        ':' +
                        namazTime.split(':').first +
                        ' am'
                : '',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class Day extends StatefulWidget {
  const Day({
    Key? key,
  }) : super(key: key);

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
  List days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  List month = [
    'January','February','March',    'April','May','June',
    'July','August','September',
    'October','November','December',

  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Text(
        days[DateTime.now().weekday - 1] +
            ', ' +
            month[DateTime.now().month - 1] +
            ' ' +DateTime.now().day.toString() + ', '+
            DateTime.now().year.toString(),
        style: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class Adhantime extends StatefulWidget {
  const Adhantime({
    Key? key,
  }) : super(key: key);

  @override
  State<Adhantime> createState() => _AdhantimeState();
}

class _AdhantimeState extends State<Adhantime> {
  var date = DateTime.now();
  var data;
  var timingNow = '';
  var namazTime = '';
  var next = '';
  var nextTime = '';
  @override
  void initState() {
    DB().initDB(dbName: 'PrayersTiming.db', tableName: 'timings').then((value) {
      setState(() {
        data = value;
      });
      for (var v in value) {
        print(v.toString());
        if (v['cityid'] == 1 &&
            v['date'].toString() ==
                DateFormat('dd-MM-yyyy').format(date).toString()) {
          setState(() {
            timingNow = v['date'];
          });

          if (int.parse(v['dhuhr'].toString().split(':').first) >=
              DateTime.now().hour &&
              DateTime.now().hour >=
                  int.parse(v['fajr'].toString().split(':').first)) {
            setState(() {
              next = 'Dhuhr';
              nextTime = v['dhuhr'];

            });
          } else if (int.parse(v['asr'].toString().split(':').first) >=
              DateTime.now().hour &&
              DateTime.now().hour >=
                  int.parse(v['dhuhr'].toString().split(':').first)) {
            setState(() {
              next = 'Asr';
              nextTime = v['asr'];
            });
          } else if (int.parse(v['maghrib'].toString().split(':').first) >=
              DateTime.now().hour &&
              DateTime.now().hour >=
                  int.parse(v['asr'].toString().split(':').first)) {
            setState(() {
              next = 'Maghrib';
              nextTime = v['maghrib'];
            });
          } else if (int.parse(v['isha'].toString().split(':').first) >=
              DateTime.now().hour &&
              DateTime.now().hour >=
                  int.parse(v['maghrib'].toString().split(':').first)) {
            setState(() {
              next = 'Isha';
              nextTime = v['isha'];
            });
          } else if (DateTime.now().hour >=
              int.parse(v['isha'].toString().split(':').first)) {
            setState(() {
              next = 'Fajr';
              nextTime =v['fajr'];
            });
          } else {
            print({
              int.parse(v['dhuhr'].toString().split(':').first) >
                  DateTime.now().hour &&
                  DateTime.now().hour <
                      int.parse(v['fajr'].toString().split(':').first)
            }.toString());
            print({
              int.parse(v['asr'].toString().split(':').first) >
                  DateTime.now().hour &&
                  DateTime.now().hour <
                      int.parse(v['dhuhr'].toString().split(':').first)
            }.toString());
            print({
              int.parse(v['maghrib'].toString().split(':').first) >
                  DateTime.now().hour &&
                  DateTime.now().hour <
                      int.parse(v['asr'].toString().split(':').first)
            }.toString());
            print({
              int.parse(v['isha'].toString().split(':').first) >
                  DateTime.now().hour &&
                  DateTime.now().hour <
                      int.parse(v['maghrib'].toString().split(':').first)
            }.toString());
            print({
              DateTime.now().hour >
                  int.parse(v['isha'].toString().split(':').first)
            }.toString());
          }
        }
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Next is $next ,',
            style: const TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
            child: Text(
              nextTime != '' ?int.parse(nextTime.toString().split(':').first ) > 12 ? '${int.parse(nextTime.toString().split(':').first ) - 12}' + ':' + nextTime.toString().split(':').last.split('(').first : nextTime.toString().split('(').first  : '',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, top: 18, bottom: 14),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SearchPage();
          }));
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                Icon(
                  Icons.search,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text(
                  'Search word in Quran',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Ourpost extends StatelessWidget {
  final title;
  final date;
  final description;
  final url;
  const Ourpost({
    Key? key,required this.title,required this.date,required this.description, this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  Container(
                    child: Image.asset(
                      'assets/images/postlogo.png',
                      fit: BoxFit.fill,
                    ),
                    height: 40,
                    width: 40,
                    color: Colors.green,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      SizedBox(height: 5),
                      Text(
                        date,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 9,
                bottom: 5,
              ),
              child: Text(
                description,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child:
                  // Container(
                  //   height: 10,
                  //   color: Colors.red,
                  // ),
                  Image.network(
                url,
                fit: BoxFit.fitWidth,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AyatOfTheMoment extends StatefulWidget {
  const AyatOfTheMoment({
    Key? key,
  }) : super(key: key);

  @override
  State<AyatOfTheMoment> createState() => _AyatOfTheMomentState();
}

class _AyatOfTheMomentState extends State<AyatOfTheMoment> {
  var data;
  int rng = Random().nextInt(100);
  var surahName = '';
  notificationSettings()async{
    await NotificationServices().showNotification(title: 'Aayat of the Moment',description: data != null ? data['ayat_nepali'] : 'अल्–फातिहा',);
  }


  @override
  void initState() {
    DB()
        .initDB(dbName: 'Qurannepali.db', tableName: 'nepaliquran')
        .then((value) {
      rng = Random().nextInt(value.asMap().length);
      setState(() {
        data = value.asMap()[rng];
      });

      DB()
          .initDB(dbName: 'Qurannepali.db', tableName: 'surahnames')
          .then((value) {
        for (var v in value) {
          if (v['surah_id'] == data['surah_no']) {
            setState(() {
              surahName = v['surah_name'] +
                  data['surah_no'].toString() +
                  data['ayat_no'].toString();
            });
          }
        }
      });

      print(data);
    });
    notificationSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  const CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/icqurancolor.png'),
                    radius: 20,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ayat of the Moment',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      SizedBox(height: 5),
                      Text(
                        surahName,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 5, top: 10),
                child: Text(
                  data != null ? data['ayat_nepali'] : '',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(
                children: [
                  CupertinoButton(
                    onPressed: () {},
                    child: Icon(Icons.share),
                  ),
                  CupertinoButton(
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: data['ayat_nepali'].toString()));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Copied to clipboard"),
                      ));
                    },
                    child: Icon(Icons.file_copy),
                  ),
                  CupertinoButton(
                    onPressed: () {
                      DB().bookMarkDB(
                          dbName: 'Bookmarks.db',
                          tableName: 'bookmarkstable',
                          surahId: data['surah_no'],
                          ayatPositon: data['ayat_no'],
                          ayatContent: data['ayat_nepali'],
                          surahDetail: data['ayat_arabic']);
                      //Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Bookmark added")));
                    },
                    child: Icon(Icons.bookmark),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Adhannotification extends StatelessWidget {
  const Adhannotification({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const Adhan();
          }));
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage:
                    const AssetImage('assets/images/ic_ibadacolor.png'),
                backgroundColor: Colors.blue[300],
                radius: 25,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Adhan notification',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            const Text(
              'Never miss your Prayer',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  fontSize: 14),
            ),
            const SizedBox(
              height: 5,
            )
          ]),
        ),
      ),
    );
  }
}

class Readbook extends StatefulWidget {
  const Readbook({
    Key? key,
  }) : super(key: key);

  @override
  State<Readbook> createState() => _ReadbookState();
}

class _ReadbookState extends State<Readbook> {
  var lessonContents;
  var data;
  var text = 'text';
  var rng;
  var title;
  @override
  void initState() {
    setState(() {
      rng = Random().nextInt(18 + 1);
    });

    DB().initDB(dbName: 'Book1.db', tableName: 'lessons').then((value) {
      for (var v in value) {
        if (v['les_id'] == rng) {
          setState(() => data = v);
        }
      }
    });
    DB().initDB(dbName: 'Book1.db', tableName: 'lesson_contents').then((value) {
      setState(() => lessonContents = value);
      for (var v in value) {
        if (v['id'] == rng) {
          setState(() {
            text = v['content'].toString().split('।').first;
          });
          print(v['content']);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DataPage(
              data: lessonContents,
              title: data['lesson_names'].toString(),
              book: 'भ्रमहरु को निवारण',
              les_id: data['les_id'],
            );
          }));
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10),
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          AssetImage('assets/images/ichadithyellow.png'),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Read Book',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          data != null ? data['lesson_names'] : '',
                          style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 5, top: 10),
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Know more',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Whatsnew extends StatelessWidget {
  const Whatsnew({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Whats New !",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'New things in app',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ],
                  ),
                  ImageIcon(
                    AssetImage('assets/images/ic_new_color.png'),
                    size: 40,
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  ComponentofWhatsnew(
                      text: 'Qibla\nDirection',
                      nevigate: Compass(),
                      image: 'assets/images/qiblas.png'),
                  ComponentofWhatsnew(
                      text: 'Home Screen\nWidget',
                      nevigate: Scaffold(
                        body: Center(
                          child: Text('Will be available soon...'),
                        ),
                      ),
                      image: 'assets/images/widgetpreview.png'),
                  ComponentofWhatsnew(
                      text: 'Read\nBook',
                      nevigate: Books(),
                      image: 'assets/images/ichadithcolor.png'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ComponentofWhatsnew extends StatelessWidget {
  final String text;
  final Widget nevigate;
  final image;
  const ComponentofWhatsnew({
    Key? key,
    required this.text,
    required this.nevigate,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return nevigate;
        }));
      },
      child: Column(
        children: [
          Container(
            child: Image(
              image: AssetImage(
                image,
              ),
            ),
            height: 60,
            width: 60,
          ),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
