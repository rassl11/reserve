import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../model/user.dart';
import '../screens/reserved_page.dart';
import '../utilities/funcAndData.dart';
import '../utilities/auth.dart';

class BranchSelection extends StatefulWidget {
  final AuthService _auth = AuthService();

  @override
  State<BranchSelection> createState() => _BranchSelectionState();
}

class _BranchSelectionState extends State<BranchSelection> {
  String _employeeName = '';
  String _employeeId = '';

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      final _user = Provider.of<MyUser?>(context, listen: false);
      if (_user?.uid == null) {
        WidgetsBinding.instance..addPostFrameCallback((_) => openDialog());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<MyUser?>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            Container(
              height: 50.h,
              child: ElevatedButton(
                  onPressed: () {
                    const String filial = 'west';
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserBookings(filial: filial),
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
            ),
            TextBranchSelection(),
            Container(
              width: 120.w,
              height: 50.h,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    ColorsUtils.whiteColor,
                  ),
                ),
                onPressed: () {
                  const String filial = 'Milliy';
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserBookings(filial: filial),
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
            ),
          ],
        ),
      ),
    );
  }

  openDialog() => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => WillPopScope(
          onWillPop: () => Future.value(false),
          child: Form(
            key: _formKey,
            child: AlertDialog(
              title: Text(
                'Как вас зовут?',
                textAlign: TextAlign.center,
              ),
              content: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                onChanged: (String value) {
                  _employeeName = value;
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
                autofocus: true,
                decoration: InputDecoration(hintText: 'Введите имя'),
                validator: (val) => val!.isEmpty ? 'Введите имя' : null,
              ),
              actions: [
                TextButton(
                  child: Text('Подтвердить'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      submit();
                      Future.delayed(Duration(seconds: 1), () {
                        Navigator.pop(context);
                      });
                    }
                  },
                )
              ],
            ),
          ),
        ),
      );

  Future submit() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();

    final snapShot = await FirebaseFirestore.instance
        .collection('Registered users')
        .doc(userCredential.user?.uid)
        .get();

    if (snapShot == null || !snapShot.exists) {
      await FirebaseFirestore.instance
          .collection('Registered users')
          .doc(userCredential.user?.uid)
          .set({
        'uid': userCredential.user?.uid,
        'name': _employeeName,
      });
    } else {
      await FirebaseFirestore.instance
          .collection('Registered users')
          .doc(userCredential.user?.uid)
          .get()
          .then((value) async {
        if (value['uid'].isNotEmpty) {
          await FirebaseFirestore.instance
              .collection('Registered users')
              .doc(userCredential.user?.uid)
              .set({
            'uid': value['uid'],
            'name': _employeeName,
          });
        }
      });
    }
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
