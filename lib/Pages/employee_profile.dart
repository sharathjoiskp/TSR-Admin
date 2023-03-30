import 'dart:convert';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsr_admin/Pages/Design/custom_widget_design.dart';
import 'package:tsr_admin/Pages/dashboard.dart';

import 'package:intl/intl.dart';

class EmployeProfile extends StatefulWidget {
  EmployeProfile({
    Key? key,
    required this.uid,
  }) : super(key: key);
  String uid;

  @override
  State<EmployeProfile> createState() => _EmployeProfileState();
}

class _EmployeProfileState extends State<EmployeProfile> {
  bool all = true;
  bool web = false;
  bool app = false;
  bool dm = false;
  bool webndm = false;
  bool appndm = false;
  bool webnapp = false;
  bool profile = false;
  bool notIntersted = false;

  var sector = "All";
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

  void revAll() {
    setState(() {
      all = !all;
      sector = 'All';

      web = false;
      app = false;
      dm = false;
      webndm = false;
      appndm = false;
      webnapp = false;
      profile = false;
      notIntersted = false;
    });
  }

  void revWeb() {
    setState(() {
      web = !web;
      sector = 'Web';
      all = false;
      app = false;
      dm = false;
      webndm = false;
      appndm = false;
      webnapp = false;
      profile = false;
      notIntersted = false;
    });
  }

  void revApp() {
    setState(() {
      app = !app;
      sector = 'App';
      all = false;
      web = false;
      dm = false;
      webndm = false;
      appndm = false;
      webnapp = false;
      profile = false;
      notIntersted = false;
    });
  }

  void revDm() {
    setState(() {
      dm = !dm;
      sector = 'Digital Marketing';
      all = false;
      web = false;
      app = false;
      webndm = false;
      appndm = false;
      webnapp = false;
      profile = false;
      notIntersted = false;
    });
  }

  void revWebnDm() {
    setState(() {
      webndm = !webndm;
      sector = 'Web and Dm';
      all = false;
      web = false;
      app = false;
      dm = false;

      appndm = false;
      webnapp = false;
      profile = false;
      notIntersted = false;
    });
  }

  void revAppnDm() {
    setState(() {
      appndm = !appndm;
      sector = 'App and Dm';
      all = false;
      web = false;
      app = false;
      dm = false;
      webndm = false;

      webnapp = false;
      profile = false;
      notIntersted = false;
    });
  }

  void revWebnApp() {
    setState(() {
      webnapp = !webnapp;
      sector = 'Web and App';
      all = false;
      web = false;
      app = false;
      dm = false;
      webndm = false;
      appndm = false;

      profile = false;
      notIntersted = false;
    });
  }

  void revProfile() {
    setState(() {
      profile = !profile;
      sector = 'Profile Sent';
      all = false;
      web = false;
      app = false;
      dm = false;
      webndm = false;
      appndm = false;
      webnapp = false;

      notIntersted = false;
    });
  }

  void revNotIntersted() {
    setState(() {
      notIntersted = !notIntersted;
      sector = 'Not Intersted';
      all = false;
      web = false;
      app = false;
      dm = false;
      webndm = false;
      appndm = false;
      webnapp = false;
      profile = false;
    });
  }

  int number = 0;
  @override
  Widget build(BuildContext context) {
    var ProfileStream = FirebaseFirestore.instance.collection('USER_RESPONSE');
    var AlldataStream = FirebaseFirestore.instance
        .collection('USER_RESPONSE')
        .doc(widget.uid)
        .collection('userResponse')
        .where('date', isEqualTo: DateFormat.yMd().format(_date))
        .snapshots();
    var conditionalStream = FirebaseFirestore.instance
        .collection('USER_RESPONSE')
        .doc(widget.uid)
        .collection('userResponse')
        .where('date', isEqualTo: DateFormat.yMd().format(_date))
        .where('sector', isEqualTo: sector)
        .snapshots();

    return Scaffold(
        appBar: AppBar(
          title: Text('Employee'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.black26,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder<DocumentSnapshot>(
                    future: ProfileStream.doc(widget.uid).get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }

                      if (snapshot.hasData && !snapshot.data!.exists) {
                        return Text("Document does not exist");
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 18.0, bottom: 18, left: 40, right: 40),
                          child: Stack(
                            children: [
                              Positioned(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  width: 400,
                                  height: 200,
                                  color: Colors.black12,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 200.0, top: 50),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${data['employeeName']}',
                                            style:
                                                GoogleFonts.lato(fontSize: 25),
                                          ),
                                          Text(
                                            '${data['number']}',
                                            style:
                                                GoogleFonts.lato(fontSize: 20),
                                          ),
                                          Text(
                                            '${data['branch']}',
                                            style:
                                                GoogleFonts.lato(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: CustomPaint(
                                  size: Size(400.0, 200.0),
                                  painter: RPSCustomPainter(),
                                ),
                              ),
                              Positioned(
                                width: 120,
                                height: 120,
                                top: 30,
                                left: 50,
                                child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage('images/profile.jpeg')),
                              ),
                            ],
                          ),
                        );
                      }
                      return Text('Loading....');
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.indigoAccent.shade100,
                  child: ListTile(
                    leading: Text(
                      'Number of calls on :',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    title: Text(
                      DateFormat.yMd().format(_date) +
                          '   (Click here to change)',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.calendar_today),
                    onTap: _showDatePicker,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                    future: countDoc(widget.uid, _date),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasData) {
                        List<dynamic> data = snapshot.data! as List<dynamic>;
                        return ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            GestureDetector(
                              child: custmButton(
                                title: 'All',
                                count: '${data[9]}',
                                clicked: all,
                              ),
                              onTap: () {
                                revAll();
                              },
                            ),
                            GestureDetector(
                              child: custmButton(
                                title: 'Web',
                                count: '${data[0]}',
                                clicked: web,
                              ),
                              onTap: () {
                                revWeb();
                              },
                            ),
                            GestureDetector(
                              child: custmButton(
                                title: 'App',
                                count: '${data[1]}',
                                clicked: app,
                              ),
                              onTap: () {
                                revApp();
                              },
                            ),
                            GestureDetector(
                              child: custmButton(
                                title: 'DM',
                                count: '${data[2]}',
                                clicked: dm,
                              ),
                              onTap: () {
                                revDm();
                              },
                            ),
                            GestureDetector(
                                child: custmButton(
                                  title: 'Web and DM',
                                  count: '${data[3]}',
                                  clicked: webndm,
                                ),
                                onTap: () {
                                  revWebnDm();
                                }),
                            GestureDetector(
                              child: custmButton(
                                title: 'App and DM',
                                count: '${data[5]}',
                                clicked: appndm,
                              ),
                              onTap: () {
                                revAppnDm();
                              },
                            ),
                            GestureDetector(
                              child: custmButton(
                                title: 'Web and App',
                                count: '${data[4]}',
                                clicked: webnapp,
                              ),
                              onTap: () {
                                revWebnApp();
                              },
                            ),
                            GestureDetector(
                              child: custmButton(
                                title: 'Profile Sent',
                                count: '${data[6]}',
                                clicked: profile,
                              ),
                              onTap: () {
                                revProfile();
                              },
                            ),
                            GestureDetector(
                              child: custmButton(
                                title: 'Not Intersted',
                                count: '${data[8]}',
                                clicked: notIntersted,
                              ),
                              onTap: () {
                                revNotIntersted();
                              },
                            ),
                          ],
                        );
                      }
                      return Text('Loading');
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Selected sector : ' + '$sector',
                  style: GoogleFonts.lato(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if (sector == "All")
                Container(
                  height: MediaQuery.of(context).size.height / 1.1,
                  child: StreamBuilder(
                    stream: AlldataStream,
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (streamSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(child: Text("Loading"));
                      }

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28.0),
                        child: ListView.builder(
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            int no = index;
                            number = ++index;
                            return Table(
                              border: TableBorder(
                                  bottom: BorderSide(
                                      width: 1, style: BorderStyle.solid)),
                              children: [
                                if (no == 0)
                                  TableRow(children: [
                                    CustomTableHeading(
                                      title: 'Sl.no',
                                    ),
                                    CustomTableHeading(
                                      title: 'Sector',
                                    ),
                                    CustomTableHeading(
                                      title: 'Date',
                                    ),
                                    CustomTableHeading(
                                      title: 'time',
                                    ),
                                    CustomTableHeading(
                                      title: 'Number',
                                    ),
                                    CustomTableHeading(
                                      title: 'Name',
                                    ),
                                    CustomTableHeading(
                                      title: 'WhataApp',
                                    ),
                                    CustomTableHeading(
                                      title: 'Organisation',
                                    ),
                                    CustomTableHeading(
                                      title: 'Website',
                                    ),
                                  ]),
                                TableRow(children: [
                                  TableRowInkWell(
                                    onTap: () {
                                      showdailogBox(
                                          widget.uid,
                                          streamSnapshot.data!.docs[no].id,
                                          streamSnapshot.data!.docs[no]
                                              ['sector'],
                                          streamSnapshot.data!.docs[no]
                                              ['customerName']);
                                    },
                                    child: customTableData(data: '$index'),
                                  ),
                                  TableRowInkWell(
                                    onTap: () {
                                      showdailogBox(
                                          widget.uid,
                                          streamSnapshot.data!.docs[no].id,
                                          streamSnapshot.data!.docs[no]
                                              ['sector'],
                                          streamSnapshot.data!.docs[no]
                                              ['customerName']);
                                    },
                                    child: customTableData(
                                        data: streamSnapshot.data!.docs[no]
                                            ['sector']),
                                  ),
                                  TableRowInkWell(
                                    onTap: () {
                                      showdailogBox(
                                          widget.uid,
                                          streamSnapshot.data!.docs[no].id,
                                          streamSnapshot.data!.docs[no]
                                              ['sector'],
                                          streamSnapshot.data!.docs[no]
                                              ['customerName']);
                                    },
                                    child: customTableData(
                                        data: streamSnapshot.data!.docs[no]
                                            ['date']),
                                  ),
                                  TableRowInkWell(
                                    onTap: () {
                                      showdailogBox(
                                          widget.uid,
                                          streamSnapshot.data!.docs[no].id,
                                          streamSnapshot.data!.docs[no]
                                              ['sector'],
                                          streamSnapshot.data!.docs[no]
                                              ['customerName']);
                                    },
                                    child: customTableData(
                                        data: streamSnapshot.data!.docs[no]
                                            ['time']),
                                  ),
                                  TableRowInkWell(
                                    onTap: () {
                                      showdailogBox(
                                          widget.uid,
                                          streamSnapshot.data!.docs[no].id,
                                          streamSnapshot.data!.docs[no]
                                              ['sector'],
                                          streamSnapshot.data!.docs[no]
                                              ['customerName']);
                                    },
                                    child: customTableData(
                                      data: streamSnapshot.data!.docs[no]
                                          ['contactNumber'],
                                    ),
                                  ),
                                  TableRowInkWell(
                                    onTap: () {
                                      showdailogBox(
                                          widget.uid,
                                          streamSnapshot.data!.docs[no].id,
                                          streamSnapshot.data!.docs[no]
                                              ['sector'],
                                          streamSnapshot.data!.docs[no]
                                              ['customerName']);
                                    },
                                    child: customTableData(
                                        data: streamSnapshot.data!.docs[no]
                                            ['customerName']),
                                  ),
                                  TableRowInkWell(
                                    onTap: () {
                                      showdailogBox(
                                          widget.uid,
                                          streamSnapshot.data!.docs[no].id,
                                          streamSnapshot.data!.docs[no]
                                              ['sector'],
                                          streamSnapshot.data!.docs[no]
                                              ['customerName']);
                                    },
                                    child: customTableData(
                                        data: streamSnapshot.data!.docs[no]
                                            ['whatsappNo']),
                                  ),
                                  TableRowInkWell(
                                    onTap: () {
                                      showdailogBox(
                                          widget.uid,
                                          streamSnapshot.data!.docs[no].id,
                                          streamSnapshot.data!.docs[no]
                                              ['sector'],
                                          streamSnapshot.data!.docs[no]
                                              ['customerName']);
                                    },
                                    child: customTableData(
                                        data: streamSnapshot.data!.docs[no]
                                            ['organisation']),
                                  ),
                                  TableRowInkWell(
                                    onTap: () {
                                      showdailogBox(
                                          widget.uid,
                                          streamSnapshot.data!.docs[no].id,
                                          streamSnapshot.data!.docs[no]
                                              ['sector'],
                                          streamSnapshot.data!.docs[no]
                                              ['customerName']);
                                    },
                                    child: customTableData(
                                        data: streamSnapshot.data!.docs[no]
                                            ['website']),
                                  ),
                                ]),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              Container(
                height: MediaQuery.of(context).size.height / 1.1,
                child: StreamBuilder(
                  stream: conditionalStream,
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (streamSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: Text("Loading"));
                    }

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28.0),
                      child: ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          int no = index;
                          number = ++index;
                          return Table(
                            border: TableBorder(
                                bottom: BorderSide(
                                    width: 1, style: BorderStyle.solid)),
                            children: [
                              if (no == 0)
                                TableRow(children: [
                                  CustomTableHeading(
                                    title: 'Sl.no',
                                  ),
                                  CustomTableHeading(
                                    title: 'Sector',
                                  ),
                                  CustomTableHeading(
                                    title: 'Date',
                                  ),
                                  CustomTableHeading(
                                    title: 'time',
                                  ),
                                  CustomTableHeading(
                                    title: 'Number',
                                  ),
                                  CustomTableHeading(
                                    title: 'Name',
                                  ),
                                  CustomTableHeading(
                                    title: 'WhataApp',
                                  ),
                                  CustomTableHeading(
                                    title: 'Organisation',
                                  ),
                                  CustomTableHeading(
                                    title: 'Website',
                                  ),
                                ]),
                              TableRow(children: [
                                TableRowInkWell(
                                  onTap: () {
                                    showdailogBox(
                                        widget.uid,
                                        streamSnapshot.data!.docs[no].id,
                                        streamSnapshot.data!.docs[no]['sector'],
                                        streamSnapshot.data!.docs[no]
                                            ['customerName']);
                                  },
                                  child: customTableData(data: '$index'),
                                ),
                                TableRowInkWell(
                                  onTap: () {
                                    showdailogBox(
                                        widget.uid,
                                        streamSnapshot.data!.docs[no].id,
                                        streamSnapshot.data!.docs[no]['sector'],
                                        streamSnapshot.data!.docs[no]
                                            ['customerName']);
                                  },
                                  child: customTableData(
                                      data: streamSnapshot.data!.docs[no]
                                          ['sector']),
                                ),
                                TableRowInkWell(
                                  onTap: () {
                                    showdailogBox(
                                        widget.uid,
                                        streamSnapshot.data!.docs[no].id,
                                        streamSnapshot.data!.docs[no]['sector'],
                                        streamSnapshot.data!.docs[no]
                                            ['customerName']);
                                  },
                                  child: customTableData(
                                      data: streamSnapshot.data!.docs[no]
                                          ['date']),
                                ),
                                TableRowInkWell(
                                  onTap: () {
                                    showdailogBox(
                                        widget.uid,
                                        streamSnapshot.data!.docs[no].id,
                                        streamSnapshot.data!.docs[no]['sector'],
                                        streamSnapshot.data!.docs[no]
                                            ['customerName']);
                                  },
                                  child: customTableData(
                                      data: streamSnapshot.data!.docs[no]
                                          ['time']),
                                ),
                                TableRowInkWell(
                                  onTap: () {
                                    showdailogBox(
                                        widget.uid,
                                        streamSnapshot.data!.docs[no].id,
                                        streamSnapshot.data!.docs[no]['sector'],
                                        streamSnapshot.data!.docs[no]
                                            ['customerName']);
                                  },
                                  child: customTableData(
                                    data: streamSnapshot.data!.docs[no]
                                        ['contactNumber'],
                                  ),
                                ),
                                TableRowInkWell(
                                  onTap: () {
                                    showdailogBox(
                                        widget.uid,
                                        streamSnapshot.data!.docs[no].id,
                                        streamSnapshot.data!.docs[no]['sector'],
                                        streamSnapshot.data!.docs[no]
                                            ['customerName']);
                                  },
                                  child: customTableData(
                                      data: streamSnapshot.data!.docs[no]
                                          ['customerName']),
                                ),
                                TableRowInkWell(
                                  onTap: () {
                                    showdailogBox(
                                        widget.uid,
                                        streamSnapshot.data!.docs[no].id,
                                        streamSnapshot.data!.docs[no]['sector'],
                                        streamSnapshot.data!.docs[no]
                                            ['customerName']);
                                  },
                                  child: customTableData(
                                      data: streamSnapshot.data!.docs[no]
                                          ['whatsappNo']),
                                ),
                                TableRowInkWell(
                                  onTap: () {
                                    showdailogBox(
                                        widget.uid,
                                        streamSnapshot.data!.docs[no].id,
                                        streamSnapshot.data!.docs[no]['sector'],
                                        streamSnapshot.data!.docs[no]
                                            ['customerName']);
                                  },
                                  child: customTableData(
                                      data: streamSnapshot.data!.docs[no]
                                          ['organisation']),
                                ),
                                TableRowInkWell(
                                  onTap: () {
                                    showdailogBox(
                                        widget.uid,
                                        streamSnapshot.data!.docs[no].id,
                                        streamSnapshot.data!.docs[no]['sector'],
                                        streamSnapshot.data!.docs[no]
                                            ['customerName']);
                                  },
                                  child: customTableData(
                                      data: streamSnapshot.data!.docs[no]
                                          ['website']),
                                ),
                              ]),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

class custmButton extends StatelessWidget {
  custmButton({
    Key? key,
    required this.title,
    required this.count,
    required this.clicked,
  }) : super(key: key);

  String title;
  String count;
  bool clicked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: clicked ? Colors.green : Colors.transparent,
          border: Border.all(
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        width: 150,
        height: 35,
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style: GoogleFonts.lato(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: clicked ? Colors.white : Colors.black,
              ),
            ),
            Text(
              count,
              style: GoogleFonts.lato(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: clicked ? Colors.white : Colors.black,
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class Tabel_data extends StatelessWidget {
  Tabel_data({
    super.key,
    required this.lable,
  });
  String lable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        lable,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}

class Custmer_card extends StatelessWidget {
  Custmer_card({super.key, required this.data});

  String data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        data,
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
      ),
    );
  }
}

showdailogBox(uid, phoneNumber, sector, clientName) {
  var Stream = FirebaseFirestore.instance
      .collection('USER_RESPONSE')
      .doc(uid)
      .collection('userResponse')
      .doc(phoneNumber)
      .collection('response')
      .snapshots();
  Get.defaultDialog(
      title: 'Conversation',
      titleStyle: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w700),
      content: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 300,
                height: 120,
                color: Colors.redAccent.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        phoneNumber,
                        style: GoogleFonts.lato(
                            fontSize: 19, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        clientName,
                        style: GoogleFonts.lato(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        sector,
                        style: GoogleFonts.lato(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
              CustomPaint(
                size: Size(300.0, 120.0),
                painter: RPSCustomPainter1(),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 500,
            height: 220,
            child: StreamBuilder(
                stream: Stream,
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
                        return ListTile(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black, width: .5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                streamSnapshot.data!.docs[index]['date'],
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 15),
                              ),
                              Text(
                                streamSnapshot.data!.docs[index]['time'],
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ],
                          ),
                          title: Text(
                            streamSnapshot.data!.docs[index]['response'],
                            style: TextStyle(
                                color: Colors.blue.shade900,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      });
                }),
          ),
        ],
      ));
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Colors.indigoAccent
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(199.57, 199.38);
    path0.quadraticBezierTo(44.64, 117.64, 97.8, 21.78);
    path0.quadraticBezierTo(91.32, -1.28, 0.04, -0.18);
    path0.lineTo(-0.96, 198.38);
    path0.lineTo(199.57, 199.38);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Colors.greenAccent.shade400
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(0.0, 118.0);
    path0.quadraticBezierTo(131.15, 85.1, 150.6, 2.0);
    path0.quadraticBezierTo(169.1, -2.25, 0.0, 0.4);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
