import 'package:flutter/material.dart';
import 'package:theummah/Brain/db.dart';

class Quranicdictionary extends StatefulWidget {
  const Quranicdictionary({Key? key}) : super(key: key);

  @override
  State<Quranicdictionary> createState() => _QuranicdictionaryState();
}

class _QuranicdictionaryState extends State<Quranicdictionary> {
  var data;
  var search ;
  @override
  void initState() {
    DB().initDB(dbName: 'Dictionary.db', tableName: 'dicttable').then((value) {
      setState(() {
        data = value;
      });
      print(value.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (v){
            setState(() {
              search = v;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search.....',
            hintStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: search == null && data != null
          ? ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                return ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DictionaryMeaning(
                          title: data[i]['word'], meaning: data[i]['meaning']);
                    }));
                  },
                  title: Text(data[i]['word']),
                  trailing: Icon(
                    Icons.keyboard_arrow_right_outlined,
                  ),
                );
              })
          : data != null ? ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                return data[i]['word']
                        .toString()
                        .contains(search.toString().trim())
                    ? ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DictionaryMeaning(
                                title: data[i]['word'],
                                meaning: data[i]['meaning']);
                          }));
                        },
                        title: Text(data[i]['word']),
                        trailing: Icon(
                          Icons.keyboard_arrow_right_outlined,
                        ),
                      )
                    : Container();
              }): Container(),
    );
  }
}

class DictionaryMeaning extends StatelessWidget {
  final title;
  final meaning;
  const DictionaryMeaning(
      {Key? key, required this.title, required this.meaning})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 5),
            Text(meaning)
          ],
        ),
      ),
    );
  }
}
