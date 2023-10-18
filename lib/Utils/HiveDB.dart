
// HiveDB

import 'package:hive/hive.dart';
import 'package:qurhealth_task/Models/Character.dart';

class HiveDB {

  String dbName;

  HiveDB({required this.dbName});

  void saveData({required Character collection}) {
    final box = Hive.box(dbName);

    box.put(collection.id, collection.toJson());
  }

  List<Map<String, dynamic>> getAllData() {
    final box = Hive.box(dbName);

    List<Map<String, dynamic>> arrAllData = [];

    for (var val in box.values) {
      final dictVal = Map<String, dynamic>.from(val);

      arrAllData.add(dictVal);
    }

    return arrAllData;
  }

  Map<String, dynamic> getDataByKey(int key) {
    final box = Hive.box(dbName);
    final arrAllData = box.get(key);

    return Map<String, dynamic>.from(arrAllData);
  }
  
}


