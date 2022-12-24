import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:theummah/Brain/db.dart';
import 'package:theummah/Brain/getData.dart';
import 'package:theummah/Brain/location.dart';

class PrayerSettings extends StatefulWidget {
  const PrayerSettings({Key? key}) : super(key: key);

  @override
  State<PrayerSettings> createState() => _PrayerSettingsState();
}

class _PrayerSettingsState extends State<PrayerSettings> {
  var connectionStatus = false;
  var data;
  var location;
  var method;
  var methodID = 8;
  checkInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        setState(() {
          connectionStatus = true;
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      connectionStatus = false;
    }
  }
  @override
  void initState() {
    getLocation();
    checkInternet();
    super.initState();
  }

  getNamazTimeTable() async {
    await GetData()
        .getTimeTable(location[0]['cityname'].toString().split(','), methodID)
        .then((value) {
      DB().updateNamazTimeTable(value['data']);
      print(value.toString());
    });
  }

  getLocation() async {
    await DB()
        .initDB(dbName: 'PrayersTiming.db', tableName: 'cities')
        .then((value) {
      setState(() {
        location = value;
      });
    });
  }

  getCurrentLocation() async {
    await LocationService.getAddressFromLatLong().then((value) {
      setState(() => data = value);
    });
    await getLocation();
    await getNamazTimeTable();
  }

  getConventionMethod() async {
    await GetData().getConvention().then((value) {
      method = value;
    });
    await getLocation();
    await getNamazTimeTable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prayer Timing Settings'),
      ),
      body: connectionStatus == false
          ? Container(
        height: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Text('To manage setting please turn on internate',style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
            Image.asset('assets/images/noInternet.jpg'),
          ],
        ),
      )
          :Column(
        children: [
          InkWell(
            onTap: () async {
              getCurrentLocation();
            },
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Text(
                        'Location',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                    ),
                    Text(
                      location == null
                          ? 'city'
                          : location[0]['cityname'].toString(),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await getConventionMethod();
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Convention Method'),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                  method['data']['MWL']['name'].toString()),
                              onTap: () async {
                                setState(() {
                                  methodID = method['data']['MWL']['id'];
                                });
                                await getNamazTimeTable();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: Text(
                                  method['data']['ISNA']['name'].toString()),
                              onTap: () async {
                                setState(() {
                                  methodID = method['data']['ISNA']['id'];
                                });
                                await getNamazTimeTable();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: Text(
                                  method['data']['EGYPT']['name'].toString()),
                              onTap: () async {
                                setState(() {
                                  methodID = method['data']['EGYPT']['id'];
                                });
                                await getNamazTimeTable();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: Text(
                                  method['data']['MAKKAH']['name'].toString()),
                              onTap: () async {
                                setState(() {
                                  methodID = method['data']['MAKKAH']['id'];
                                });
                                await getNamazTimeTable();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: Text(
                                  method['data']['KARACHI']['name'].toString()),
                              onTap: () async {
                                setState(() {
                                  methodID = method['data']['KARACHI']['id'];
                                });
                                await getNamazTimeTable();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: Text(
                                  method['data']['TEHRAN']['name'].toString()),
                              onTap: () async {
                                setState(() async {
                                  methodID = method['data']['TEHRAN']['id'];
                                });
                                await getNamazTimeTable();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: Text(
                                  method['data']['JAFARI']['name'].toString()),
                              onTap: () async {
                                setState(() {
                                  methodID = method['data']['JAFARI']['id'];
                                });
                                await getNamazTimeTable();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: Text(
                                  method['data']['GULF']['name'].toString()),
                              onTap: () async {
                                setState(() {
                                  methodID = method['data']['GULF']['id'];
                                });
                                await getNamazTimeTable();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: Text(
                                  method['data']['KUWAIT']['name'].toString()),
                              onTap: () async {
                                setState(() {
                                  methodID = method['data']['KUWAIT']['id'];
                                });
                                await getNamazTimeTable();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: Text(
                                  method['data']['QATAR']['name'].toString()),
                              onTap: () async {
                                setState(() {
                                  methodID = method['data']['QATAR']['id'];
                                });
                                await getNamazTimeTable();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: Text(method['data']['SINGAPORE']['name']
                                  .toString()),
                              onTap: () async {
                                setState(() {
                                  methodID = method['data']['SINGAPORE']['id'];
                                });
                                await getNamazTimeTable();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: Text(
                                  method['data']['FRANCE']['name'].toString()),
                              onTap: () async {
                                setState(() {
                                  methodID = method['data']['FRANCE']['id'];
                                });
                                await getNamazTimeTable();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: Text(
                                  method['data']['TURKEY']['name'].toString()),
                              onTap: () async {
                                setState(() {
                                  methodID = method['data']['TURKEY']['id'];
                                });
                                await getNamazTimeTable();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: Text(
                                  method['data']['RUSSIA']['name'].toString()),
                              onTap: () async {
                                setState(() {
                                  methodID = method['data']['RUSSIA']['id'];
                                });
                                await getNamazTimeTable();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: Text(method['data']['MOONSIGHTING']['name']
                                  .toString()),
                              onTap: () async {
                                setState(() {
                                  methodID =
                                      method['data']['MOONSIGHTING']['id'];
                                });
                                await getNamazTimeTable();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Text(
                        'Prayer Timing calculation',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                    ),
                    Text(
                      'Qutar',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


