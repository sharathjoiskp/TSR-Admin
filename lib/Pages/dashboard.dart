import 'dart:html';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tsr_admin/Pages/Design/custom_widget_design.dart';

import 'package:tsr_admin/Pages/employee_profile.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var Stream =
      FirebaseFirestore.instance.collection('USER_RESPONSE').snapshots();
  var _date = DateTime.now();
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((value) {
      setState(() {
        _date = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.admin_panel_settings),
        title: Text('Admin Panel'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.indigoAccent.shade100,
                child: ListTile(
                  leading: Text(
                    'Number of calls on :',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  title: Text(
                    DateFormat.yMd().format(_date) +
                        '   (Click here to change)',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.calendar_today),
                  onTap: _showDatePicker,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.2,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('USER_RESPONSE')
                      .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasError) {
                      return Center(child: Text('Something went wrong'));
                    }

                    if (streamSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          int no = index;
                          return FutureBuilder(
                              future: countDoc(
                                  streamSnapshot.data!.docs[index]['uid'],
                                  _date),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 50.0,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.black,
                                      highlightColor: Colors.red,
                                      child: Text(
                                        'Loading..',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.lato(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  );
                                }
                                if (snapshot.hasData) {
                                  List<dynamic> data =
                                      snapshot.data! as List<dynamic>;
                                  return Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      child: Table(
                                        border: TableBorder(
                                          bottom: BorderSide(
                                              width: 1,
                                              style: BorderStyle.solid),
                                        ),
                                        children: [
                                          if (no == 0)
                                            TableRow(children: [
                                              CustomTableHeading(
                                                  title: 'Employe Info'),
                                              CustomTableHeading(title: 'Web'),
                                              CustomTableHeading(title: 'App'),
                                              CustomTableHeading(title: 'DM'),
                                              CustomTableHeading(
                                                  title: 'Web and DM'),
                                              CustomTableHeading(
                                                  title: 'App and DM'),
                                              CustomTableHeading(
                                                  title: 'Web and App'),
                                              CustomTableHeading(
                                                  title: 'Profile Sent'),
                                              CustomTableHeading(
                                                  title: 'Call Later'),
                                              CustomTableHeading(
                                                  title: 'Not Intersted'),
                                              CustomTableHeading(
                                                  title: 'Total'),
                                            ]),
                                          TableRow(children: [
                                            TableRowInkWell(
                                              onTap: () {
                                                Get.to(EmployeProfile(
                                                  uid: streamSnapshot
                                                      .data!.docs[index]['uid'],
                                                ));
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      streamSnapshot
                                                              .data!.docs[index]
                                                          ['employeeName'],
                                                      style: GoogleFonts.lato(
                                                          fontSize: 20),
                                                    ),
                                                    Text(
                                                      streamSnapshot
                                                              .data!.docs[index]
                                                          ['branch'],
                                                      style: GoogleFonts.lato(
                                                          fontSize: 15),
                                                    ),
                                                    Text(
                                                      streamSnapshot
                                                              .data!.docs[index]
                                                          ['number'],
                                                      style: GoogleFonts.lato(
                                                          fontSize: 11),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            TableRowInkWell(
                                              onTap: () {
                                                Get.to(EmployeProfile(
                                                  uid: streamSnapshot
                                                      .data!.docs[index]['uid'],
                                                ));
                                              },
                                              child: customTableData(
                                                  data: '${data[0]}'),
                                            ),
                                            TableRowInkWell(
                                              onTap: () {
                                                Get.to(EmployeProfile(
                                                  uid: streamSnapshot
                                                      .data!.docs[index]['uid'],
                                                ));
                                              },
                                              child: customTableData(
                                                  data: '${data[1]}'),
                                            ),
                                            TableRowInkWell(
                                              onTap: () {
                                                Get.to(EmployeProfile(
                                                  uid: streamSnapshot
                                                      .data!.docs[index]['uid'],
                                                ));
                                              },
                                              child: customTableData(
                                                  data: '${data[2]}'),
                                            ),
                                            TableRowInkWell(
                                              onTap: () {
                                                Get.to(EmployeProfile(
                                                  uid: streamSnapshot
                                                      .data!.docs[index]['uid'],
                                                ));
                                              },
                                              child: customTableData(
                                                  data: '${data[3]}'),
                                            ),
                                            TableRowInkWell(
                                              onTap: () {
                                                Get.to(EmployeProfile(
                                                  uid: streamSnapshot
                                                      .data!.docs[index]['uid'],
                                                ));
                                              },
                                              child: customTableData(
                                                  data: '${data[5]}'),
                                            ),
                                            TableRowInkWell(
                                              onTap: () {
                                                Get.to(EmployeProfile(
                                                  uid: streamSnapshot
                                                      .data!.docs[index]['uid'],
                                                ));
                                              },
                                              child: customTableData(
                                                  data: '${data[4]}'),
                                            ),
                                            TableRowInkWell(
                                              onTap: () {
                                                Get.to(EmployeProfile(
                                                  uid: streamSnapshot
                                                      .data!.docs[index]['uid'],
                                                ));
                                              },
                                              child: customTableData(
                                                  data: '${data[6]}'),
                                            ),
                                            TableRowInkWell(
                                              onTap: () {
                                                Get.to(EmployeProfile(
                                                  uid: streamSnapshot
                                                      .data!.docs[index]['uid'],
                                                ));
                                              },
                                              child: customTableData(
                                                  data: '${data[7]}'),
                                            ),
                                            TableRowInkWell(
                                              onTap: () {
                                                Get.to(EmployeProfile(
                                                  uid: streamSnapshot
                                                      .data!.docs[index]['uid'],
                                                ));
                                              },
                                              child: customTableData(
                                                  data: '${data[8]}'),
                                            ),
                                            TableRowInkWell(
                                              onTap: () {
                                                Get.to(EmployeProfile(
                                                  uid: streamSnapshot
                                                      .data!.docs[index]['uid'],
                                                ));
                                              },
                                              child: customTableData(
                                                  data: '${data[9]}'),
                                            ),
                                          ]),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return Text('loading');
                              });
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<dynamic>> countDoc(
  String uid,
  DateTime date,
) async {
  int countWeb = 0;
  int countApp = 0;
  int countDm = 0;
  int countWebnDm = 0;
  int countWebnApp = 0;
  int countAppnDm = 0;
  int countProfile = 0;
  int countCallLater = 0;
  int countNotIntersted = 0;
  int countTotal = 0;
  String todaydate = DateFormat.yMd().format(date);

  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(uid)
      .collection('userResponse')
      .where('date', isEqualTo: todaydate)
      .where('sector', isEqualTo: 'Web')
      .get()
      .then((QuerySnapshot querySnapshot) {
    countWeb = querySnapshot.docs.length;
  });
  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(uid)
      .collection('userResponse')
      .where('date', isEqualTo: todaydate)
      .where('sector', isEqualTo: 'App')
      .get()
      .then((QuerySnapshot querySnapshot) {
    countApp = querySnapshot.docs.length;
  });

  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(uid)
      .collection('userResponse')
      .where('date', isEqualTo: todaydate)
      .where('sector', isEqualTo: 'Digital Marketing')
      .get()
      .then((QuerySnapshot querySnapshot) {
    countDm = querySnapshot.docs.length;
  });
  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(uid)
      .collection('userResponse')
      .where('date', isEqualTo: todaydate)
      .where('sector', isEqualTo: 'Web and Digital Marketing')
      .get()
      .then((QuerySnapshot querySnapshot) {
    countWebnDm = querySnapshot.docs.length;
  });
  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(uid)
      .collection('userResponse')
      .where('date', isEqualTo: todaydate)
      .where('sector', isEqualTo: 'Web and App')
      .get()
      .then((QuerySnapshot querySnapshot) {
    countWebnApp = querySnapshot.docs.length;
  });

  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(uid)
      .collection('userResponse')
      .where('date', isEqualTo: todaydate)
      .where('sector', isEqualTo: 'App and Digital Marketing')
      .get()
      .then((QuerySnapshot querySnapshot) {
    countAppnDm = querySnapshot.docs.length;
  });

  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(uid)
      .collection('userResponse')
      .where('date', isEqualTo: todaydate)
      .where('sector', isEqualTo: 'Profile Sent')
      .get()
      .then((QuerySnapshot querySnapshot) {
    countProfile = querySnapshot.docs.length;
  });
  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(uid)
      .collection('userResponse')
      .where('date', isEqualTo: todaydate)
      .where('sector', isEqualTo: 'Call Later')
      .get()
      .then((QuerySnapshot querySnapshot) {
    countCallLater = querySnapshot.docs.length;
  });
  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(uid)
      .collection('userResponse')
      .where('date', isEqualTo: todaydate)
      .where('sector', isEqualTo: 'Not Intersted')
      .get()
      .then((QuerySnapshot querySnapshot) {
    countNotIntersted = querySnapshot.docs.length;
  });
  await FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(uid)
      .collection('userResponse')
      .where('date', isEqualTo: todaydate)
      .get()
      .then((QuerySnapshot querySnapshot) {
    countTotal = querySnapshot.docs.length;
  });
  return [
    countWeb,
    countApp,
    countDm,
    countWebnDm,
    countWebnApp,
    countAppnDm,
    countProfile,
    countCallLater,
    countNotIntersted,
    countTotal,
  ];
}
