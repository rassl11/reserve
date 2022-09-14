import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

abstract class Func {

  static returnData(String filial){
    if(filial == 'milliy'){
      return FirebaseFirestore.instance.collection('milliy');
    } else {
      return FirebaseFirestore.instance.collection('west');
    }
  }
  
  static returnSubcollection(String filial){
    if(filial == 'milliy'){
      return 'milliYarchive';
    } else {
      return 'westYarchive';
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