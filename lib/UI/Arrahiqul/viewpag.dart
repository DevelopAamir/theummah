import 'package:flutter/material.dart';

class Views extends StatelessWidget {
  const Views({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            width: 130,
            child: TabBar(labelPadding: EdgeInsets.zero, tabs: [
              Tab(
                text: 'Topic 1',
              ),
              Tab(
                text: 'Topic 2',
              ),
            ]),
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Cardss(
                      text: 'Chapter:',
                      text2: 'Location',
                    ),
                    Cardss(
                      text: 'Datas',
                      text2: '',
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Cardss(
                      text: 'Chapter:',
                      text2: 'Location',
                    ),
                    Cardss(
                      text: 'Datas',
                      text2: '',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Cardss extends StatelessWidget {
  final String text;
  final String text2;

  const Cardss({
    Key? key,
    required this.text,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    text2,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  )
                ],
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
    );
  }
}
