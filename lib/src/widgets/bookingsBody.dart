import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tkbooking111/src/utilities/func.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../main.dart';
import '../utilities/colors.dart';

class bookingsBody extends StatefulWidget {
  const bookingsBody({required this.filial});
  final String filial;

  @override
  State<bookingsBody> createState() => _bookingsBodyState(filial: filial);
}

class _bookingsBodyState extends State<bookingsBody> {
  _bookingsBodyState({required this.filial});
  String filial;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: StreamBuilder(
        stream: Func.returnData(filial).orderBy('created_date', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          print(!snapshot.hasData || snapshot.data!.docs.isEmpty);
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return textNoBooked();
          }
          return Container(
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  key: Key(snapshot.data!.docs[index].id),
                  padding: EdgeInsets.only(top: 5.r),
                  child: Card(
                    color: ColorsUtils.darkgreenColor,
                    child: Container(
                      padding: EdgeInsets.all(15.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${snapshot.data?.docs[index].get('name')}, ${snapshot.data?.docs[index].get('time')}',
                            style:
                                TextStyle(fontSize: 30.sp, color: ColorsUtils.whiteColor),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          getTextFiled(
                            text:
                                'Кол-во персон: ${snapshot.data?.docs[index].get('count')}',
                          ),
                          TextButton(
                            onPressed: () {
                              _makePhoneCall(
                                  snapshot.data?.docs[index].get('number'));
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(0)),
                            ),
                            child: Text(
                                '${snapshot.data?.docs[index].get('number')}',
                                style: TextStyle(
                                    fontSize: 24.sp,
                                    color: ColorsUtils.whiteColor,
                                    fontWeight: FontWeight.normal)),
                          ),
                          getTextFiled(
                            text:
                                'Стол: ${snapshot.data?.docs[index].get('numberTable')}',
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 150.w,
                                height: 40.h,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Func.returnData(filial)
                                        .doc(snapshot.data!.docs[index].id)
                                        .delete();
                                  },
                                  child: Text(
                                    'Подтвердить',
                                    style: TextStyle(fontSize: 18.sp),
                                  ),
                                ),
                              ),
                              Container(
                                height: 40.h,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Func.returnData(filial)
                                        .doc(snapshot.data!.docs[index].id)
                                        .delete();
                                    Future<QuerySnapshot> books = Func.returnData(filial)
                                        .doc(snapshot.data!.docs[index].id)
                                        .collection(Func.returnSubcollection(filial))
                                        .get();
                                    books.then((value) {
                                      value.docs.forEach((element) {
                                        Func.returnData(filial)
                                            .doc(snapshot.data!.docs[index].id)
                                            .collection(Func.returnSubcollection(filial))
                                            .doc(element.id)
                                            .delete()
                                            .then((value) => print("success"));
                                      });
                                    });
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.red,
                                    ),
                                  ),
                                  child: Icon(Icons.delete),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}

Widget textNoBooked() {
  return Center(
    child: Text(
      'Брони отсутствуют',
      style: TextStyle(fontSize: 22.sp, color: ColorsUtils.darkgreenColor),
    ),
  );
}

Widget getTextFiled({required String text}) {
  return Text(text, style: TextStyle(fontSize: 24.sp, color: ColorsUtils.whiteColor));
}
