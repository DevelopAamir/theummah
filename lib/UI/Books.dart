import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theummah/Brain/db.dart';

import 'Readbook.dart';

class Books extends StatefulWidget {
  const Books({Key? key}) : super(key: key);

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue, Colors.orange],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Extra Books'),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Wrap(
                    children:const [
                      MainCards(

                        nevigator: VaramHaru(),
                        text: 'भ्रमहरु को निवारण',
                      ),
                      MainCards(

                        nevigator: MuslimLaiJanne(),
                        text: 'मुस्लिमहरु\nलाई जान्नै पर्ने\nकु्राहरु ',
                      ),
                      MainCards(

                        nevigator: VaramHaru(),
                        text: 'Misconception about Islam',
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainCards extends StatelessWidget {
  final String text;

  final Widget nevigator;
  const MainCards({
    Key? key,
    required this.text,

    required this.nevigator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return nevigator;
          }));
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/book.png'),fit: BoxFit.fill),
          ),

            width: MediaQuery.of(context).size.width / 2.5,
            height: 200,
            child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
                textAlign : TextAlign.center
            ),
          ))

        // Container(
        //   height: 200,
        //   width: MediaQuery.of(context).size.width/2.5,
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(15),
        //     boxShadow: const [
        //       BoxShadow(
        //         color: Colors.black26,
        //         blurRadius: 6,
        //         offset: Offset(0, 2),
        //       ),
        //     ],
        //   ),
        //   child: Stack(
        //
        //     children: [
        //
        //       Center(
        //         child: Text(
        //           text,
        //           style: const TextStyle(
        //               color: Colors.grey,
        //               fontWeight: FontWeight.bold,
        //               fontSize: 15),
        //             textAlign : TextAlign.center
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        );
  }
}
