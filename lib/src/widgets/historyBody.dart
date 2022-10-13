// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../utilities/funcAndData.dart';

// class HistoryBodyWidget extends StatefulWidget {
//   const HistoryBodyWidget({required this.filial});
//   final String filial;
//   @override
//   State<HistoryBodyWidget> createState() => _HistoryBodyWidgetState();
// }

// class _HistoryBodyWidgetState extends State<HistoryBodyWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: () async {
//         setState(() {});
//       },
//       child: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('Reserve')
//             .doc(Func.returnDataNow())
//             .collection(Func.returnSubcollection(widget.filial))
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           print(!snapshot.hasData || snapshot.data!.docs.isEmpty);
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(
//               child: Text(
//                 'Брони отсутствовали',
//                 style: TextStyle(
//                     fontSize: 22.sp, color: ColorsUtils.darkgreenColor),
//               ),
//             );
//           }
//           return Container(
//             child: ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Container(
//                   key: Key(snapshot.data!.docs[index].id),
//                   padding: EdgeInsets.only(top: 5.r),
//                   child: Card(
//                     color: ColorsUtils.darkgreenColor,
//                     child: Container(
//                       padding: EdgeInsets.all(15.r),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '${snapshot.data?.docs[index].get('name')}, ${snapshot.data?.docs[index].get('time')}',
//                                 style: TextStyle(
//                                     fontSize: 24.sp,
//                                     color: ColorsUtils.whiteColor),
//                               ),
//                               Container(
//                                 width: 60,
//                                 height: 60,
//                                 alignment: Alignment.center,
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                     image: AssetImage("assets/img/bg-tiime.png"),
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 child: Text(
//                                     '${snapshot.data?.docs[index].get('numberTable')}',
//                                     style: TextStyle(
//                                         fontSize: 20.sp,
//                                         color: ColorsUtils.darkgreenColor)),
//                               ),
//                             ],
//                           ),
//                           Text(
//                               'Кол-во персон: ${snapshot.data?.docs[index].get('count')}',
//                               style: TextStyle(
//                                   fontSize: 22.sp,
//                                   color: ColorsUtils.whiteColor)),
//                           SizedBox(
//                             height: 10.h,
//                           ),
//                           Text('${snapshot.data?.docs[index].get('number')}',
//                               style: TextStyle(
//                                   fontSize: 22.sp,
//                                   color: ColorsUtils.whiteColor)),
//                           SizedBox(
//                             height: 5.h,
//                           ),
//                           SizedBox(
//                             height: 20.h,
//                           ),
//                           Container(
//                             alignment: Alignment.center,
//                             padding: EdgeInsets.all(5.r),
//                             decoration: BoxDecoration(
//                               color: Colors.green,
//                             ),
//                             child: Text(
//                                 '${snapshot.data?.docs[index].get('date')}',
//                                 style: TextStyle(
//                                     fontSize: 22.sp,
//                                     color: ColorsUtils.whiteColor)),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
