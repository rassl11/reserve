import 'package:flutter/material.dart';
import '../utilities/colors.dart';
import '../widgets/historyBody.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../main.dart';

class HistoryBooking extends StatelessWidget {
  const HistoryBooking({required this.filial});
  final String filial;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsUtils.darkgreenColor,
      ),
      body: HistoryBodyWidget(filial: filial),
    );
  }
}
