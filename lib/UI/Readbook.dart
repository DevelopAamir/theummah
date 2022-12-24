import 'package:flutter/material.dart';
import 'package:theummah/Brain/db.dart';
import 'package:theummah/UI/viewpage.dart';

class VaramHaru extends StatefulWidget {
  const VaramHaru({Key? key}) : super(key: key);

  @override
  State<VaramHaru> createState() => _VaramHaruState();
}

class _VaramHaruState extends State<VaramHaru> {
  var data;
  var lessonContents;
  @override
  void initState() {
    DB().initDB(dbName: 'Book1.db', tableName: 'lessons').then((value) {
      setState(() => data = value);
    });
    DB().initDB(dbName: 'Book1.db', tableName: 'lesson_contents').then((value) {
      setState(() => lessonContents = value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('भ्रमहरु को निवारण'),
      ),
      body: Container(
        child:data == null?Container(): ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, i) {
            return Cards(
              navigatorss: DataPage(
                data: lessonContents,
                title: data[i]['lesson_names'],
                book: 'भ्रमहरु को निवारण',
                les_id: data[i]['les_id'],
              ),
              title: data[i]['lesson_names'],
              i: '${i + 1}',
            );
          },
        ),
      ),
    );
  }
}

class DataPage extends StatelessWidget {
  final les_id;
  final book;
  final title;
  final data;
  const DataPage(
      {Key? key,
      this.data,
      this.title,
      required this.book,
      required this.les_id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return book == 'भ्रमहरु को निवारण'
                  ? data[index]['id'] == les_id
                      ? Text(
                          data[index]['content'].toString(),
                          style: TextStyle(fontSize: 15),
                        )
                      : Container()
                  : data[index]['content_id'] == les_id
                      ? Text(
                          data[index]['primary_content'].toString(),
                          style: TextStyle(fontSize: 15),
                        )
                      : Container();
            }),
      ),
    );
  }
}

class Cards extends StatelessWidget {
  final i;
  final title;
  final Widget navigatorss;
  const Cards({
    Key? key,
    required this.navigatorss,
    this.title,
    this.i,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return navigatorss;
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  i,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MuslimLaiJanne extends StatefulWidget {
  const MuslimLaiJanne({Key? key}) : super(key: key);

  @override
  State<MuslimLaiJanne> createState() => _MuslimLaiJanneState();
}

class _MuslimLaiJanneState extends State<MuslimLaiJanne> {
  var data;
  var lessonContents;
  @override
  void initState() {
    DB().initDB(dbName: 'GKIslam.db', tableName: 'topics').then((value) {
      setState(() => data = value);
    });
    DB().initDB(dbName: 'GKIslam.db', tableName: 'content').then((value) {
      setState(() => lessonContents = value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('मुस्लिमहरु लाई जान्नै पर्ने कु्राहरु '),
      ),
      body: Container(
        child:data == null?Container(): ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, i) {
            return Cards(
              navigatorss: DataPage(
                data: lessonContents,
                title: data[i]['topics'],
                book: null,
                les_id: data[i]['id'],
              ),
              title: data[i]['topics'],
              i: '${i + 1}',
            );
          },
        ),
      ),
    );
  }
}
