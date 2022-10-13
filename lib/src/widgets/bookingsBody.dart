import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utilities/funcAndData.dart';
import '../screens/update_page.dart';

class bookingsBody extends StatefulWidget {
  const bookingsBody({required this.filial});
  final String filial;

  @override
  State<bookingsBody> createState() => _bookingsBodyState();
}

class _bookingsBodyState extends State<bookingsBody> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
        });
      },
      child: StreamBuilder(
        stream: DataBase.db
            .collection('Reserve')
            .doc(Func.returnDataNow())
            .collection(Func.returnSubcollection(widget.filial))
            .snapshots(),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${snapshot.data?.docs[index].get('name')}, ${snapshot.data?.docs[index].get('arrival time')}',
                                style: TextStyle(
                                    fontSize: 24.sp,
                                    color: ColorsUtils.whiteColor),
                              ),
                              Container(
                                width: 60,
                                height: 60,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage("assets/img/bg-tiime.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Text(
                                    '${snapshot.data?.docs[index].get('number table')}',
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        color: ColorsUtils.darkgreenColor)),
                              ),
                            ],
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
                                '${snapshot.data?.docs[index].get('phone number')}',
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    color: ColorsUtils.whiteColor,
                                    fontWeight: FontWeight.normal)),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 35.h,
                                child: ElevatedButton(
                                  onPressed: () {
                                    String collectionName = 'Archive';
                                    moveDocumentToOtherCollection(
                                        snapshot.data!.docs[index].id,
                                        collectionName);
                                  },
                                  child: Icon(Icons.check),
                                ),
                              ),
                              Container(
                                height: 35.h,
                                child: ElevatedButton(
                                    onPressed: () {
                                      String collectionName = 'Did not come';
                                      moveDocumentToOtherCollection(
                                          snapshot.data!.docs[index].id,
                                          collectionName);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Colors.red,
                                      ),
                                    ),
                                    child: Icon(Icons.close)),
                              ),
                              Container(
                                height: 35.h,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UserUpdate(
                                            snapshotId:
                                                snapshot.data!.docs[index].id,
                                            filial: widget.filial,
                                          ),
                                          maintainState: false,
                                        ));
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.grey,
                                    ),
                                  ),
                                  child: Icon(Icons.edit),
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

  moveDocumentToOtherCollection(snapshotId, collectionName) async {
    var oldColl = DataBase.db
        .collection('Reserve')
        .doc(Func.returnDataNow())
        .collection(Func.returnSubcollection(widget.filial))
        .doc(snapshotId);
    var newColl = DataBase.db
        .collection(collectionName)
        .doc(Func.returnDataNow())
        .collection(Func.returnSubcollection(widget.filial))
        .doc(oldColl.id);

    DocumentSnapshot? snapshot = await oldColl.get()
        // ignore: missing_return
        .then((docSnapshot) {
      if (docSnapshot.exists) {
        // document id does exist
        print('Successfully found document');

        newColl
            .set({
              'name': docSnapshot['name'],
              'phone number': docSnapshot['phone number'],
              'arrival time': docSnapshot['arrival time'],
              'count': docSnapshot['count'],
              'number table': docSnapshot['number table'],
              'date': docSnapshot['date'],
              'created date': docSnapshot['created date'],
              'employeeID': docSnapshot['employeeID'],
            })
            .then((value) => print("document moved to different collection"))
            .catchError((error) => print("Failed to move document: $error"))
            .then((value) => ({
                  oldColl
                      .delete()
                      .then((value) =>
                          print("document removed from old collection"))
                      .catchError((error) {
                    newColl.delete();
                    print("Failed to delete document: $error");
                  })
                }));
      } else {
        //document id doesnt exist
        print('Failed to find document id');
      }
    });
  }
}

Future<void> _makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
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
  return Text(text,
      style: TextStyle(fontSize: 22.sp, color: ColorsUtils.whiteColor));
}
