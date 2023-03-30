import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../employee_profile.dart';

class customTableData extends StatelessWidget {
  customTableData({
    super.key,
    required this.data,
  });

  String data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Tabel_data(
          lable: data,
        ),
      ),
    );
  }
}

class CustomTableHeading extends StatelessWidget {
  CustomTableHeading({
    required this.title,
    super.key,
  });
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber.shade200,
      height: 50,
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class textstyle extends StatelessWidget {
  textstyle({
    required this.title,
    required this.count,
    super.key,
  });
  String title;
  String count;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        Text(
          count,
          style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
