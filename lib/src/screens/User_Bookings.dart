import 'package:flutter/material.dart';
import '../utilities/colors.dart';
import '../widgets/bookingsBody.dart';
import 'User_Add.dart';
import 'User_History.dart';

class UserBookings extends StatelessWidget {
  const UserBookings({required this.filial});
  final String filial;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsUtils.darkgreenColor,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HistoryBooking(filial: filial)));
            },
            icon: const Icon(
              Icons.history,
              color: ColorsUtils.whiteColor,
            ),
          )
        ],
      ),
      body: bookingsBody(filial: filial),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPerson(filial: filial),
            ),
          );
        },
        tooltip: '',
        child: const Icon(Icons.add),
      ),
    );
  }
}
