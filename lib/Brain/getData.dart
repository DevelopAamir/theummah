import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:theummah/Constants/api.dart';
import 'package:http/http.dart' as http;
import 'package:theummah/UI/homecomponent.dart';

class GetData{
  Future getTimeTable(location, method)async{
    var data;
    DateTime date = DateTime.now();
    final api = 'http://api.aladhan.com/v1/calendarByCity?city=${location.first}&country=${location.last}&method=$method&month=${date.month}&year=${date.year}';
    try{
      await http.get(Uri.parse(api)).then((value){
        print(api);
        data =jsonDecode(value.body);


      });
    }catch (e){
      print(e);
    }

    return data;
  }
  Future getConvention()async{
    var data;
    final api = Api.conventionTime;
    try{
      await http.get(Uri.parse(api)).then((value){

        data = jsonDecode(value.body);
        print(data.toString());
      });
    }catch (e){
      print(e);
    }

    return data;
  }

  Future<List<Ourpost>> getPosts()async{
    List<Ourpost> posts = [];
    final api = Api.getPosts;
    try{
      await http.get(Uri.parse(api)).then((value)async{
         final data = jsonDecode(value.body);
         print(data.toString());
         for(var d in data){
           if(d['status'] == 'Approved'){

               posts.add(Ourpost(title:'Our Posts', date:DateFormat('yyyy-MM-dd').format((DateTime.parse(d['dated']))), description:  d['caption'], url: 'https://ummahnp.com/AndroidImageUpload/uploads/${d['url']}'));


           }

         }

      });
    }catch(e){
      
    }
    return posts;
  }

  Future<http.Response> getPost(id)async{

    http.Response response = await http.get(Uri.parse(Api.getPost + id));
    print(response.body);
    return response;
  }
}