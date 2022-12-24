import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theummah/Brain/db.dart';
import 'package:theummah/UI/Quran/Card/ayat.dart';

class GotoIndex extends StatefulWidget {
  GotoIndex({Key? key}) : super(key: key);

  @override
  State<GotoIndex> createState() => _GotoIndexState();
}

class _GotoIndexState extends State<GotoIndex> {
  final ayat = TextEditingController();

  final para = TextEditingController();

  var data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Go to index'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: para,
              decoration: InputDecoration(hintText: 'Enter Para'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: ayat,
              decoration: InputDecoration(hintText: 'Enter Surah'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoButton(
                color: Colors.indigo,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Search'),
                ),
                onPressed: () async {
                  await DB()
                      .initDB(
                          dbName: 'Qurannepali.db', tableName: 'nepaliQuran')
                      .then((value) {
                    setState(() {
                      data = value;
                    });
                  });
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Scaffold(
                          appBar: AppBar(
                            title: Text(para.text + ' : ' + ayat.text),
                          ),
                          body: data != null
                              ? ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context, i) {
                                    return data[i]['ayat_no'].toString() == ayat.text &&
                                            data[i]['surah_no'].toString() == para.text
                                        ? AayatCard(
                                            data: data[i],
                                            language: 'ayat_nepali',
                                            searched: ayat.text.toString() +':'+ para.text.toString(),
                                          )
                                        : Container();
                                  })
                              : Container(),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}
