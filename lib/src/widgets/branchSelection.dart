import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:tkbooking111/src/utilities/funcFilial.dart';
import '../screens/User_Bookings.dart';
import '../utilities/colors.dart';

class BranchSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/bg-main.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ButtonWest(),
            TextBranchSelection(),
            ButtonMilliy(),
          ],
        ),
      ),
    );
  }
}

class ButtonMilliy extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      height: 50.h,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            ColorsUtils.whiteColor,
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserBookings(filial: 'milliy'),
              ));
        },
        child: Text(
          'Milliy',
          style: TextStyle(
            fontSize: 18.sp,
            color: ColorsUtils.darkgreenColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

Widget TextBranchSelection() {
  return Container(
    padding: EdgeInsets.only(top: 75, bottom: 75),
    child: Text(
      'Выберите филиал',
      style: TextStyle(color: ColorsUtils.whiteColor, fontSize: 26.sp),
    ),
  );
}

class ButtonWest extends StatelessWidget {
  const ButtonWest({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      height: 50.h,
      child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserBookings(filial: 'west'),
                ));
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              ColorsUtils.whiteColor,
            ),
          ),
          child: Text(
            'Westminster',
            style: TextStyle(
              fontSize: 18.sp,
              color: ColorsUtils.darkgreenColor,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}
