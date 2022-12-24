import 'package:flutter/material.dart';
import 'package:theummah/Brain/db.dart';
import 'package:theummah/UI/Quran/Card/ayat.dart';

class SearchPage extends StatefulWidget {
   SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();
  var data;
  var language = 'ayat_nepali';
  @override
  void initState() {
    DB().initDB(dbName: 'Qurannepali.db',tableName: 'nepaliQuran').then((value){

      setState(() {

        data = value;
      });

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0,right: 8.0),
          child: TextField(
            onChanged: (text){
              setState(() {

              });
            },
            controller: searchController,
            decoration: InputDecoration(
              focusColor: Colors.white,
              hoverColor: Colors.white,
              hintText: 'Search'
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: data == null? Container():ListView.builder(
                itemCount: data.length,
                itemBuilder: (context,index){
              return data[index][language].toString().contains(searchController.text) && searchController.text.isNotEmpty?  AayatCard(data: data[index],searched: searchController.text,language: language,) : Container();
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    title: Text('Select Language'),
                    content: Container(
                      height: 300,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text('SAHIH INTERNATIONAL - ENGLISH'),
                            onTap: (){
                              setState(() {
                                language = 'sahih_International';
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                              title: Text('MUHAMMAD JUNA GARHI - HINDI'),
                            onTap: (){
                              setState(() {
                                language = 'hindi_quran';
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text('MOHAMMAD FAROOQ KHAN - HINDI'),
                            onTap: (){
                              setState(() {
                                language = 'hindi_quran';
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text('SIRAJUL ULOOM - NEPALI'),
                            onTap: (){
                              setState(() {
                                language = 'ayat_nepali';
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text('MUHAMMAD JUNA GARHI - URDU'),
                            onTap: (){
                              setState(() {
                                language = 'urdu_translation';
                              });
                              Navigator.pop(context);
                            },
                          ),

                        ],
                      ),
                    ),
                  );
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 40,
                width: double.infinity,
                child: Center(
                  child: Text(
                    language.replaceAll('_', ' '),
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Colors.blue),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
