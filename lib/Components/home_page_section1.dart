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
      Container(child: Divider(color: Colors.white,), width: 18, padding: EdgeInsets.only(top: 15, right: 5),),
      Expanded(child: Column(
        children: [
          Text('Welcome Back, User', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 40),),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.call, color: yellow,),
                      fillColor: grey.withOpacity(0.5),
                      filled: true,
                      hintText: "Enter the phone number you want to send money to",
                      hintStyle: GoogleFonts.montserrat(color: Colors.white)
                  ),
                  style: GoogleFonts.montserrat(color: CupertinoColors.white),
                  onSubmitted: (val){
                    if(val.length!=10){
                      Get.snackbar("Error", "Please enter a valid phone number", colorText: Colors.white, snackPosition: SnackPosition.TOP);
                    }else{
                      Get.defaultDialog(
                        cancel: TextButton(child: Text('Cancel'), onPressed: (){},),
                        confirm: TextButton(child: Text('Confirm'), onPressed: (){},),
                        onCancel: (){
                          Get.back();
                        },
                        onConfirm: (){
                          //TODO implement on confirm
                          Get.back();
                        },

                        backgroundColor: Colors.white.withOpacity(0.2),
                        titleStyle: GoogleFonts.montserrat(color: Colors.white),
                        title: "Confirmation", content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(text: 'Are you sure you want to send money to ', style: GoogleFonts.montserrat(color: Colors.white)),
                            TextSpan(text: '${phoneNumberController.text.toString()}', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: Colors.white)),
                          ]),),
                      ),);
                    }
                  },
                ),
              ),
              IconButton(onPressed: () {  }, icon: Icon(FontAwesomeIcons.qrcode, color: Colors.white,),)
            ],
          )
        ],
      )),
    ],
  );
}