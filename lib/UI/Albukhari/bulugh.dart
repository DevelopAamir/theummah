import 'package:flutter/material.dart';
import 'package:theummah/Brain/db.dart';


class Bulugh extends StatefulWidget {
  const Bulugh({Key? key}) : super(key: key);

  @override
  State<Bulugh> createState() => _BulughState();
}

class _BulughState extends State<Bulugh> {
  var data;
  @override
  void initState() {
    DB()
        .initDB(dbName: 'BulughAlmaram.db', tableName: 'bulugbooks')
        .then((value) {
      print(value.toString());
      setState(() {
        data = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bulugh Al Maram'),
        ),
        body:data == null?Container():  ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, i) {
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return BulughHadithBook();
                }));
              },
              child: Card(
                  child: Column(
                children: [
                  Text(data[i]['booknamenepali']),
                  Text(data[i]['booknamearabic']),
                  Text(data[i]['booknameenglish']),
                ],
              )),
            );
          },
        ));
  }
}


class BulughHadithBook extends StatefulWidget {
  const BulughHadithBook({Key? key}) : super(key: key);

  @override
  _BulughHadithBookState createState() => _BulughHadithBookState();
}

class _BulughHadithBookState extends State<BulughHadithBook> {
  var data;
  @override
  void initState() {
    DB().initDB(dbName: 'BulughAlmaram.db',tableName: 'bulighbooksadhya').then((value){
      print(value.toString());
      setState(() {
        data = value;
      });
    }
    );    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title : Text('')),
      body:data == null ?Container(): ListView.builder(itemCount : data.length,itemBuilder: (context,i){
        return ListTile(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => BulughHadith()));
          },
          title: Text(data[i]['adhyanamenepali']),

        );
      }),
    );
  }
}

class BulughHadith extends StatefulWidget {
  const BulughHadith({Key? key}) : super(key: key);

  @override
  _BulughHadithState createState() => _BulughHadithState();
}

class _BulughHadithState extends State<BulughHadith> {
  var data;
  @override
  void initState() {
    DB().initDB(dbName: 'BulughAlmaram.db',tableName: 'adhyacontent').then((value)
    {
      print(value.toString());
      setState(() {
        data = value;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bulugh Al Maram'),),
      body:data == null ?Container(): ListView.builder(itemBuilder: (context,i){
        return Cards(
          name: 'Bulugh Al Maram' + data[i]['aydhyaid'].toString() + data[i]['hadithid'].toString(),
          datas: data[i]['haditharabic'],
          translation: data[i]['hadithnepali'],
        );
      }),
    );
  }
}
class Cards extends StatelessWidget {
  final name;
  final datas;
  final translation;
  const Cards({
    Key? key, this.name, this.datas, this.translation,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      child: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 35.0, right: 30, bottom: 10, top: 10),
                        child: Text(
                          name,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.white,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    '$datas\n$translation',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colors.grey[600],
                thickness: 1,
              )
            ],
          ),
        ],
      ),
    );
  }
}

