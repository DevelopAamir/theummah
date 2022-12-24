import 'package:flutter/material.dart';
import 'package:theummah/Brain/db.dart';
import 'package:substring_highlight/substring_highlight.dart';

class AayatCard extends StatelessWidget {
  final language;
  final searched;
  final data;
  const AayatCard({Key? key, this.data, this.searched, this.language})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Alert'),
                content: Text('Do You Want to add Bookmarks'),
                actions: [
                  OutlinedButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: Text('No')),
                  OutlinedButton(
                      onPressed: () {
                        DB().bookMarkDB(
                            dbName: 'Bookmarks.db',
                            tableName: 'bookmarkstable',
                            surahId: data['surah_no'],
                            ayatPositon: data['ayat_no'],
                            ayatContent: data['ayat_nepali'],
                            surahDetail: data['ayat_arabic']);
                        Navigator.pop(context);
                      },
                      child: Text('Yes')),
                ],
              );
            });
      },
      child: Card(
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(data['surah_no'].toString() +
                      ':' +
                      data['ayat_no'].toString()),
                )),
            Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(data['ayat_arabic']),
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SubstringHighlight(
                    text: data[
                        language], // search result string from database or something
                    term: searched == null ? '' : searched, // user typed "et"
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
