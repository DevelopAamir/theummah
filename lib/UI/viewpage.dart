import 'package:flutter/material.dart';

class ViewPage extends StatelessWidget {
  const ViewPage({Key? key}) : super(key: key);

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
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
