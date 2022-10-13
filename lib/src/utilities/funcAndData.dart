import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

abstract class Func {
  static returnDataNow() {
    return DateTime.now().day.toString();
  }

  static returnSubcollection(String filial) {
    if (filial == 'Milliy') {
      return 'Milliy';
    } else {
      return 'Westminster';
    }
  }

  static nowDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  static nowTime() {
    var now = new DateTime.now();
    var formatter = new DateFormat('HH:mm:ss');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

}

abstract class DataBase {
  static var db = FirebaseFirestore.instance;
}

abstract class ColorsUtils {
  static const Color darkgreenColor = Color.fromRGBO(0, 47, 47, 50);
  static const Color greenColor = Colors.green;
  static const Color whiteColor = Colors.white;
}
