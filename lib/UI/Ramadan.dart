import 'package:flutter/material.dart';
import 'package:theummah/Brain/db.dart';

import 'viewpage.dart';

class Ramadan extends StatefulWidget {
  const Ramadan({Key? key}) : super(key: key);

  @override
  State<Ramadan> createState() => _RamadanState();
}

class _RamadanState extends State<Ramadan> {
  var data;
  @override
  void initState() {
    DB().initDB(dbName: 'RajoData.db',tableName: 'rojasub').then((value){
      setState(() {
        data= value;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ramadan Duwa'),

      ),
      body:data == null? Container(): ListView.builder(
          itemCount: data.length,
          itemBuilder: (context,i){
        return ListTile(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return RojaContent(title: data[i]['sub_name'],subId: data[i]['sub_id'],);
            }));
          },
          title: Text(data[i]['sub_name']),
        );
      })
    );
  }
}

class RojaContent extends StatefulWidget {
  final subId;
  final title;
  const RojaContent({Key? key, this.subId, this.title}) : super(key: key);

  @override
  _RojaContentState createState() => _RojaContentState();
}

class _RojaContentState extends State<RojaContent> {
  var data;

  @override
  void initState() {
    DB().initDB(dbName: 'RajoData.db',tableName: 'rojacontent').then((value){
      setState(() {
        data= value;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body:data == null ? Container():  ListView.builder(
          itemCount: data.length,
          itemBuilder: (context,i){
            return data[i]['sub_id'] == widget.subId ? Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Align(alignment:Alignment.centerRight, child: Text(data[i]['dua_arabic'],style:const TextStyle(fontSize: 18,),textAlign: TextAlign.right,)),
                    Align(alignment:Alignment.centerLeft, child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data[i]['dua_nepali'],style:const TextStyle(fontSize: 18)),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(data[i]['dua_meaning'],style:const TextStyle(color: Colors.blue,fontSize: 18),),
                    ),
                  ],
                ),
              ),
            ):Container();
          }),
    );
  }
}


