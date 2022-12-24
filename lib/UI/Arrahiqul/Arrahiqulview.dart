import 'package:flutter/material.dart';

import 'topics.dart';

class View extends StatelessWidget {
  const View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ar-Raheeq-Al-Makhtum'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            children: [
              Cards(
                navigatorss: Topics(),
              ),
              Cards(
                navigatorss: Topics(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Cards extends StatelessWidget {
  final Widget navigatorss;
  const Cards({
    Key? key,
    required this.navigatorss,
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
                  '1',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Data\nhcdbibcdcjb\nhbzkcb\nsbh',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
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
