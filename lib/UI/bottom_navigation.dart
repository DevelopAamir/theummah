import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theummah/Brain/db.dart';
import 'package:theummah/Brain/getData.dart';
import 'package:theummah/Brain/location.dart';
import 'package:theummah/UI/Ibadaat.dart';
import 'package:theummah/UI/More.dart';

import 'Albukhari/Hadith.dart';
import 'Home.dart';

import 'Quran/Quran.dart';
import 'Settings.dart';
import 'about.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {

  int _selectedIndex = 2;

  static TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);
  static final List<Widget> _widgetOptions = <Widget>[
    Quran(optionStyle: optionStyle),
    Hadith(optionStyle: optionStyle),
    Home(optionStyle: optionStyle),
    Ibadaat(optionStyle: optionStyle),
    More(optionStyle: optionStyle),
  ];
  static List<Widget> appTitle = <Widget>[
    Text(
      'Quran',
      style: optionStyle,
    ),
    Text(
      'Hadith',
      style: optionStyle,
    ),
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Ibadaat',
      style: optionStyle,
    ),
    Text(
      'More',
      style: optionStyle,
    ),
  ];
  getNamazTimeTable() async {
    var location = await getLocation();
    await GetData()
        .getTimeTable(location[0]['cityname'].toString().split(','), 8)
        .then((value) {
      DB().updateNamazTimeTable(value['data']);
      print(value.toString());
    });

  }

  getLocation() async {
    var data;
    await DB()
        .initDB(dbName: 'PrayersTiming.db', tableName: 'cities')
        .then((value) {

        data = value;

    });
    return data;
  }
  @override
  void initState() {

    getNamazTimeTable();
    super.initState();
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(

            width: double.infinity,
            child: Image.asset(
              'assets/images/quranbg.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            child: _widgetOptions.elementAt(
              _selectedIndex,
            ),
          ),
        ],
      ),
      appBar: AppBar(title: appTitle.elementAt(_selectedIndex)),
      drawer: Drawer(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Image.asset(
                    'assets/bg.jpg',
                    fit: BoxFit.cover,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                  ),
                  height: 200,
                  width: double.infinity,
                ),
                Drawerbuttons(
                  icons: Icons.details,
                  text: 'About App',
                  widget: Aboutpage(),
                ),
                Drawerbuttons(
                  icons: Icons.settings,
                  text: 'Settings',
                  widget: Settings(),
                ),
                Divider(
                  color: Colors.grey[400],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Communicate',
                    style: TextStyle(
                        color: Colors.grey[600], fontWeight: FontWeight.bold),
                  ),
                ),
                Drawerbuttons(
                  icons: Icons.share,
                  text: 'Share',
                  widget: Scaffold(),
                ),
                Drawerbuttons(
                  icons: Icons.star,
                  text: 'Rate',
                  widget: Scaffold(),
                ),
                Drawerbuttons(
                  icons: Icons.facebook,
                  text: 'Facebook',
                  widget: Scaffold(),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/ic_quran.png',),color: Colors.black,),
            label: 'Quran',
          ),
          const BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/ic_hadith.png',),size: 30,color: Colors.black,),
            label: 'Hadith',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/ic_ibadaat.png',),color: Colors.black,),
            label: 'Ibadaat',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.more),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedFontSize: 12.0,
        selectedItemColor: const Color(0xff2B762F),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        onTap: _onItemTapped,
      ),
    );
  }
}

class Drawerbuttons extends StatelessWidget {
  final String text;
  final IconData icons;
  final Widget widget;
  const Drawerbuttons({
    Key? key,
    required this.text,
    required this.icons,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return widget;
        }));
      },
      child: Row(
        children: [
          Icon(
            icons,
            color: Colors.grey[600],
          ),
          SizedBox(
            width: 25,
          ),
          Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
