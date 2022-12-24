import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  Future initDB({dbName, tableName, query}) async {
    var data;
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    final exists = await databaseExists(path);
    if (exists) {
      print('present db');
    } else {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {}
      ByteData data = await rootBundle.load(join('assets', dbName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);

      print('db initialized');
    }
    final db = await openDatabase(path);
    if (query == null) {
      await db
          .query(
        tableName,
      )
          .then((value) {
        print(value.toString());
        data = value;
      });
    } else {}

    return data;
  }

  Future bookMarkDB(
      {dbName,
      tableName,
      surahId,
      ayatPositon,
      ayatContent,
      surahDetail,
      task}) async {
    var data;
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    final exists = await databaseExists(path);
    if (exists) {
      print('present db');
    } else {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {}
      ByteData data = await rootBundle.load(join('assets', dbName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);

      print('db initialized');
    }
    final db = await openDatabase(path);
    if (task == null) {
      await db.insert(tableName, {
        "surah_id": surahId,
        "ayat_positon": ayatPositon,
        "ayat_content": ayatContent,
        "surah_detail": surahDetail
      });
    } else {
      await db.rawDelete(
          'DELETE FROM $tableName WHERE surah_id = ? AND ayat_positon = ?',
          [surahId, ayatPositon]);
    }

    return data;
  }

  Future updateLocationSetting(
      {currentLocation}) async {
    var data;
    var dbName = 'PrayersTiming.db';
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    final exists = await databaseExists(path);
    if (exists) {
      print('present db');
    } else {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {}
      ByteData data = await rootBundle.load(join('assets', dbName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);

      print('db initialized');
    }
    final db = await openDatabase(path);
    try{
      db.update('cities', {'cityname':currentLocation,},where: 'id = ?',whereArgs: ['1']);
    }catch(e){
      print(e);
    }


  }
  Future updateNamazTimeTable(
      value) async {

    var dbName = 'PrayersTiming.db';
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    final exists = await databaseExists(path);
    if (exists) {
      print('present db');
    } else {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {}
      ByteData data = await rootBundle.load(join('assets', dbName));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);

      print('db initialized');
    }
    final db = await openDatabase(path);
    try{
      db.delete('timings',where: 'cityid = ?',whereArgs: [1]);

      for(var d in value){
        db.insert('timings', {
        'cityid' :	1,
        'date'	:d['date']['gregorian']['date'].toString().replaceAll('(+0545)', ''),
        'fajr'	:d['timings']['Fajr'].toString().replaceAll('(+0545)', ''),
        'dhuhr':d['timings']['Dhuhr'].toString().replaceAll('(+0545)', ''),
        'asr':	d['timings']['Asr'].toString().replaceAll('(+0545)', ''),
        'maghrib':	d['timings']['Maghrib'].toString().replaceAll('(+0545)', ''),
        'isha' :	d['timings']['Isha'].toString().replaceAll('(+0545)', ''),
        });
      }

    }catch(e){
      print(e);
    }


  }

}
