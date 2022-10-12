import 'package:flutter/material.dart';
import 'add_page.dart';
import '../widgets/bookingsBody.dart';
import '../utilities/funcAndData.dart';

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
                      builder: (context) => AddPerson(
                          filial: filial)));
            },
            icon: Icon(
              Icons.add,
              color: ColorsUtils.whiteColor,
            ),
          )
        ],
      ),
      body: bookingsBody(filial: filial),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => AddPerson(filial: filial),
      //       ),
      //     );
      //   },
      //   tooltip: '',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
