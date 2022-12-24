import 'package:flutter/material.dart';
import 'package:theummah/Brain/db.dart';

import 'final.dart';

class BukhariView extends StatefulWidget {
  const BukhariView({Key? key}) : super(key: key);

  @override
  State<BukhariView> createState() => _BukhariViewState();
}

class _BukhariViewState extends State<BukhariView> {
  var data;
  @override
  void initState() {
    DB()
        .initDB(dbName: 'Bukharihadees.db', tableName: 'bukharibooks')
        .then((value) {
      setState(() {
        data = value;
        print(value.toString());
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
        body:data == null? Container():  ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              return Card(
                  navigators: FinalView(),
                  body: Column(
                    children: [
                      Text(data[i]['booknamenepali']),
                      Text(data[i]['booknamearabic']),
                      Text(data[i]['booknameenglish']),
                    ],
                  ));
            }));
  }
}

class Card extends StatelessWidget {
  final Widget navigators;
  final body;
  const Card({
    Key? key,
    required this.navigators,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return navigators;
        }));
      },
      child: Column(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            child: Padding(padding: const EdgeInsets.all(10.0), child: body),
          ),
          Divider(
            color: Colors.grey[600],
            thickness: 1,
          )
        ],
      ),
    );
  }
}
