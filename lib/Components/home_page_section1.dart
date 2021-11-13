import 'package:easyupi/Screens/amount_entering_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

var phoneNumberController = TextEditingController();

Row HomePageSection1() {
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
          child: Column(
        children: [
          Text(
            'Welcome Back, User',
            style: GoogleFonts.montserrat(color: Colors.white, fontSize: 40),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.call,
                        color: yellow,
                      ),
                      fillColor: grey.withOpacity(0.5),
                      filled: true,
                      hintText:
                          "Enter the phone number you want to send money to",
                      hintStyle: GoogleFonts.montserrat(color: Colors.white)),
                  style: GoogleFonts.montserrat(color: CupertinoColors.white),
                  onSubmitted: (val) {
                    if (val.length != 10 || !val.isNum) {
                      Get.snackbar("Error", "Please enter a valid phone number",
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP);
                    } else {
                      Get.dialog(AlertDialog(
                        backgroundColor: Colors.black.withOpacity(0.5),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        title: Text(
                          'Confirmation',
                          style: GoogleFonts.montserrat(color: Colors.white),
                        ),
                        content: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Are you sure you want to send money to ',
                                style: GoogleFonts.montserrat(
                                    color: Colors.white)),
                            TextSpan(
                                text:
                                    '${phoneNumberController.text.toString()}',
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ]),
                        ),
                        actions: [
                          TextButton(onPressed: (){
                            Get.back();
                          }, child: Text('Cancel', style: GoogleFonts.montserrat(color: yellow),),),
                          TextButton(onPressed: (){
                            Get.back();
                            Get.to(AmountEnteringScreen(val));
                          }, child: Text('Confirm', style: GoogleFonts.montserrat(color: yellow),))
                        ],
                      ));
                    }
                  },
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.qrcode,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      )),
    ],
  );
}
