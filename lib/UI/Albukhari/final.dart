import 'package:flutter/material.dart';
import 'package:theummah/Brain/db.dart';

class FinalView extends StatefulWidget {

  const FinalView({Key? key,}) : super(key: key);

  @override
  State<FinalView> createState() => _FinalViewState();
}

class _FinalViewState extends State<FinalView> {
  var data;
  @override
  void initState() {
    DB().initDB(dbName: 'Bukharihadees.db',tableName:'bukharibookscontent' ).then((value) {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Sahih Bukhari'),
      ),
      body:data == null? Container(): ListView.builder(
          itemCount: data.length,
          itemBuilder: (context,i){
            return Card(
              name: 'Sahih Bukhari ${data[i]['hadithId']}',
              datas: data[i]['haditharabic'],
              translation: data[i]['hadithnepali'],
            );
          })
    );
  }
}

class Card extends StatelessWidget {
  final name;
  final datas;
  final translation;
  const Card({
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
