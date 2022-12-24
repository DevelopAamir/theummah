import 'package:flutter/material.dart';

class Readbooks extends StatelessWidget {
  const Readbooks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Read Book'),
      ),
      body: Column(
        children: [
          Container(
            child: Center(
              child: Text(
                'DATA',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
            ),
            height: 40,
            width: double.infinity,
            color: Colors.blue,
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Datas',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Datas',
                    ),
                  ],
                ),
                width: double.infinity,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
