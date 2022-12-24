import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theummah/Brain/db.dart';
import 'package:theummah/UI/viewpage.dart';

class Namaz extends StatefulWidget {
  const Namaz({Key? key}) : super(key: key);

  @override
  State<Namaz> createState() => _NamazState();
}

class _NamazState extends State<Namaz> {
  var data;
  @override
  void initState() {
    DB().initDB(dbName: 'NamajData.db',tableName: 'namajsub').then((value){
      setState(() {
        data= value;
      });
      print(value.toString());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Namaz'),
        backgroundColor: Colors.indigo,
      ),
      body:data == null ? Container(): ListView.builder(
          itemCount: data.length,
          itemBuilder:(context,i){
            return ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return NamazContent(subId: data[i]['sub_id'],);
                }));
              },
              title: Text(data[i]['sub']),
            );

      })
    );
  }
}

class NamazContent extends StatefulWidget {
  final subId;
  const NamazContent({Key? key, this.subId}) : super(key: key);

  @override
  _NamazContentState createState() => _NamazContentState();
}

class _NamazContentState extends State<NamazContent> {
  var data;
  @override
  void initState() {
    DB().initDB(dbName: 'NamajData.db',tableName: 'namajcontent').then((value){
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
      appBar: AppBar(),
      body:data == null ?Container(): ListView.builder(
          itemCount:  data.length,
          itemBuilder:(context,i){
            return data[i]['sub_id'] == widget.subId ?Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(alignment: Alignment.centerRight ,child: Text(data[i]['dua_arabic'])),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(alignment: Alignment.centerLeft ,child: Text(data[i]['dua_nepali'])),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(alignment: Alignment.centerLeft ,child: Text(data[i]['dua_meaning'])),
                  ),


                ],
              ),
            ):Container();
          }),
    );
  }
}

