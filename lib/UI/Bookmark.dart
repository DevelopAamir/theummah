import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theummah/Brain/db.dart';
import 'package:theummah/UI/Quran/Card/ayat.dart';
import 'package:theummah/UI/Quran/readQuranPage.dart';

class BookMark extends StatefulWidget {
  const BookMark({Key? key}) : super(key: key);

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  var data;
  var surah;
  @override
  void initState() {
    DB()
        .initDB(dbName: 'Bookmarks.db', tableName: 'bookmarkstable')
        .then((value) {
      print(value.toString());
      setState(() {
        data = value;
      });
    });
    DB()
        .initDB(dbName: 'Qurannepali.db', tableName: 'nepaliquran')
        .then((value) {
      setState(() {
        surah = value;
      });
    });

    super.initState();
  }

  var language = 'ayat_nepali';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Mark'),
      ),
      body: data == null || data.isEmpty
          ? Container()
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    List<Widget> particularSurah = [];
                    var index = 50;
                    for (var s in surah) {
                      if (s['surah_no'] == data[i]['surah_id']) {
                        if( data[i]['ayat_positon'] == s['ayat_no']){
                           index = s['ayat_no'];
                        }
                        setState(() {
                          particularSurah.add(Container(
                              child: data[i]['ayat_positon'] == s['ayat_no']
                                  ? Container(
                                      color: Colors.red,
                                      child: AayatCard(
                                        data: s,
                                        language: language,
                                      ))
                                  : AayatCard(
                                      data: s,
                                      language: language,
                                    )));
                        });
                      }
                    }

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ReadQuran(
                        data: particularSurah,
                        index: index,
                        title: '',
                      );
                    }));
                  },
                  onLongPress: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Are You sure ?'),
                            content: Container(
                              height: 150,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(data[i]['surah_id'].toString() +
                                        ':' +
                                        data[i]['ayat_positon'].toString()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(data[i]['surah_detail'])),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(data[i]['ayat_content'])),
                                  )
                                ],
                              ),
                            ),
                            actions: [
                              OutlinedButton(
                                  onPressed: () async {
                                    await DB().bookMarkDB(
                                        surahId: data[i]['surah_id'],
                                        ayatPositon: data[i]['ayat_positon'],
                                        tableName: 'bookmarkstable',
                                        dbName: 'Bookmarks.db',
                                        task: 'delete');
                                    await DB()
                                        .initDB(
                                            dbName: 'Bookmarks.db',
                                            tableName: 'bookmarkstable')
                                        .then((value) {
                                      print(value.toString());
                                      setState(() {
                                        data = value;
                                      });
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text('Yes'))
                            ],
                          );
                        });
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Text(data[i]['surah_id'].toString() +
                            ':' +
                            data[i]['ayat_positon'].toString()),
                        Text(data[i]['surah_detail']),
                        Text(data[i]['ayat_content'])
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
