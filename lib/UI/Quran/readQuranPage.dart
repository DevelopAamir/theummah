


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:theummah/UI/Quran/Card/ayat.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ReadQuran extends StatefulWidget {
  final List<Widget> data;
  final  index;
  final String title;
  const ReadQuran({Key ?key,required this.data,this.index, required this.title}) : super(key: key);

  @override
  State<ReadQuran> createState() => _ReadQuranState();
}

class _ReadQuranState extends State<ReadQuran> {
  final ItemScrollController _controller = ItemScrollController();
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp)=>scrollToIndex(widget.index) );

    super.initState();
  }
  scrollToIndex(index){
    if(widget.index != null){_controller.jumpTo(index: index - 1);}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: ScrollablePositionedList.builder(
        itemScrollController: _controller,
        itemCount:widget.data.length ,
        itemBuilder: (context,i){
          return widget.data[i];
        },

      ),


    );

  }
}
