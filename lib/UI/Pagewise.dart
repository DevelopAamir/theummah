import 'package:flutter/material.dart';

import 'package:theummah/Brain/db.dart';

class PageWiseQuran extends StatefulWidget {
  PageWiseQuran({Key? key}) : super(key: key);

  @override
  State<PageWiseQuran> createState() => _PageWiseQuranState();
}

class _PageWiseQuranState extends State<PageWiseQuran> {
  Map data = {};
  var pageNo = 1;
  @override
  void initState() {
    DB()
        .initDB(dbName: 'PageWiseQuran.db', tableName: 'pagewisequran')
        .then((value) {
      Map page = {};
      for (var v in value) {
        if (page.containsKey(v['page'])) {
          page[v['page']] =
              page[v['page']] + v['ayat_arabic'] + ' (${v['ayat_no']}) ';
        } else {
          page[v['page']] = v['ayat_arabic'] + ' (${v['ayat_no']}) ';
        }
      }
      setState(() {
        data = page;
      });
      print(value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page no : ' + pageNo.toString()),
      ),
      body: data.isEmpty
          ? Container()
          : PageView.builder(
        reverse: true,
              onPageChanged: (p) {
                setState(() {
                  pageNo = p + 1;
                });
              },
              itemCount: data.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        data[index + 1].toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
