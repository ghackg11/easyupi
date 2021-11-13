import 'package:easyupi/Screens/upi_pay.dart';
import 'package:easyupi/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:upi_pay/upi_pay.dart';

class AmountEnteringScreen extends StatelessWidget {

  String phoneNumber;
  var amountController = TextEditingController();

  AmountEnteringScreen(this.phoneNumber);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Material(
        color: darkBlack,
        child: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Divider(
                  color: Colors.white,
                ),
                width: 18,
                padding: EdgeInsets.only(right: 5),
              ),
              Expanded(
                child: Column(
                  children: [
                    RichText(text: TextSpan(children: [
                      TextSpan(text: "to ", style: GoogleFonts.montserrat(color: CupertinoColors.white, fontSize: 20)),
                      TextSpan(text: '$phoneNumber', style: GoogleFonts.montserrat(color: yellow, fontSize: 25)),]
                    ),),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              LineIcons.indianRupeeSign,
                              color: yellow,
                            ),
                            fillColor: grey.withOpacity(0.5),
                            filled: true,
                            hintText:
                            "Enter the amount",
                            hintStyle: GoogleFonts.montserrat(color: Colors.white)),
                        style: GoogleFonts.montserrat(color: CupertinoColors.white),
                        onSubmitted: (val){
                          sendPayment();
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        child: Text('Send'),
                        onPressed: (){
                          sendPayment();
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void sendPayment(){
    var val = amountController.text;
    if( val.isNotEmpty && val.isNum) {
      Get.dialog(AlertDialog(
        backgroundColor: Colors.black.withOpacity(0.5),
        contentPadding:
        EdgeInsets.symmetric(
            horizontal: 24, vertical: 12),
        title: Text(
          'Confirmation',
          style: GoogleFonts.montserrat(
              color: Colors.white),
        ),
        content: RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(children: [
            TextSpan(
                text: 'Are you sure you want to send ',
                style: GoogleFonts.montserrat(
                    color: Colors.white)),
            TextSpan(
                text:
                '${val}',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            TextSpan(
                text: ' to ',
                style: GoogleFonts.montserrat(
                    color: Colors.white)),
            TextSpan(
                text:
                '${phoneNumber}',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ]),
        ),
        actions: [
          TextButton(onPressed: () {
            Get.back();
          },
            child: Text('Cancel',
              style: GoogleFonts.montserrat(
                  color: yellow),),),
          TextButton(onPressed: () {
            upiPayment();
          },
              child: Text('Confirm',
                style: GoogleFonts.montserrat(
                    color: yellow),))
        ],
      ));
    }else{
      Get.snackbar("Error", "Please enter a valid amount",
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP);
    }
  }

  void upiPayment() async{

    Get.to(UpiPayment());



  }

}
