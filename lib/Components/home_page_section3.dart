import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';



Row HomePageSection3() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        child: Divider(
          color: Colors.white,
        ),
        width: 18,
        padding: EdgeInsets.only(top: 15, right: 5),
      ),
      Expanded(
        child: Text('Contacts'),
      )
    ],
  );
}
