import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:theummah/Brain/db.dart';
import 'package:theummah/Brain/location.dart';
import 'Settings.dart';

class Adhan extends StatefulWidget {
  const Adhan({Key? key}) : super(key: key);

  @override
  State<Adhan> createState() => _AdhanState();
}

class _AdhanState extends State<Adhan> {
  var data;
  var loc = '';
  List namazs = [
    'fajr',
    'dhuhr',
    'asr',
    'maghrib',
    'isha'
  ];
  @override
  void initState() {
    DB()
        .initDB(dbName: 'PrayersTiming.db', tableName: 'timings')
        .then((value){
          for(var i= 0; i<value.length; i++){
            if(value[i]['cityid'] == 1){
              setState(() => data = value[i]);

            }
          }
    });
    DB().initDB(dbName: 'PrayersTiming.db',tableName: 'cities').then((value){
      setState(() {
        loc = value[0]['cityname'];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: ()async {

              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PrayerSettings();
              }));
            },
            icon: Icon(Icons.settings),
          )
        ],
        elevation: 0,

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Prayer Timings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year} ',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        loc,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Set Manually',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Switch(value:false, onChanged: (a){})
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 273,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.circular(15)),
                            child:data == null? Container(): ListView.builder(
                                itemCount: namazs.length,
                                itemBuilder: (context, i) {
                                  return  Cards(
                                    namaz: namazs[i].toString().replaceRange(0, 1,  namazs[i].toString()[0].toUpperCase()),
                                    txts: int.parse(data[namazs[i]]
                                        .toString()
                                        .split(':').first) > 12 ? '${
                                      int.parse(data[namazs[i]]
                                              .toString()
                                              .split(':')
                                              .first) -
                                          12
                                    }' + ':' + data[namazs[i]]
                                        .toString()
                                        .split(':').elementAt(1).split('(').first + 'pm' : data[namazs[i]]
                                        .toString().split(':').elementAt(0) + ':'+ data[namazs[i]]
                                        .toString().split(':').elementAt(1).split('(').first+ 'am',
                                  );})),
                      ),
                      Expanded(flex: 1,child: Container())
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Cards extends StatelessWidget {
  final namaz;
  final String txts;
  const Cards({
    Key? key,
    required this.txts, this.namaz,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                namaz,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
              Row(
                children: [
                  Text(
                    txts,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                  const Icon(
                    Icons.alarm,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius:namaz == 'Fajr'? BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)  ) : namaz == 'Isha' ? BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)  ) : BorderRadius.zero,
        ),
      ),
    );
  }
}
