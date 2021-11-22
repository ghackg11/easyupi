import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class FAQScreen extends StatelessWidget {
   FAQScreen({Key? key}) : super(key: key);

  var pressed1 = false;
  var pressed2 = false;
  var pressed3 = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FAQ'),),
      body: ListView(
        children: [
          StatefulBuilder(
            builder: (context, state) {
              return Column(
                children: [
                  ListTile(
                    title: Text('What is the use of this app?', style: GoogleFonts.montserrat(),),
                    trailing: Icon(pressed1?LineIcons.angleUp: LineIcons.angleDown),
                    onTap: (){
                      state((){
                        pressed1 = !pressed1;
                      });
                    },
                  ),
                  if(pressed1)
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('We are making an app that provides various ways to initiate UPI Payments.UPI is a Unified Payment Interface. It is an initiative taken by the NationalPayments Corporation of India (NPCI) together with the Reserve Bank of Indiaand the Indian Banks Association (IBA). It allows us to use our mobile phonesas virtual debit cards. Using this, we can do bank-to-bank transfers anytimeand anywhere. We don’t need to visit banks for money transfers and balanceinquiries. All this is on our phones, we just need a UPI Id and a pin to performpayments that are secure and instantaneous. It is a single platform thatmerges various services under the same umbrella.', style: GoogleFonts.montserrat(), textAlign: TextAlign.justify,),
                  ),
                  Divider()
                ],
              );
            }
          ),
          StatefulBuilder(
              builder: (context, state) {
                return Column(
                  children: [
                    ListTile(
                      title: Text('How to use this app?', style: GoogleFonts.montserrat(),),
                      trailing: Icon(pressed2?LineIcons.angleUp: LineIcons.angleDown),
                      onTap: (){
                        state((){
                          pressed2 = !pressed2;
                        });
                      },
                    ),
                    if(pressed2)
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text('Go to the help section to learn how to use this app.', style: GoogleFonts.montserrat(), textAlign: TextAlign.justify,),
                      ),
                    Divider()
                  ],
                );
              }
          ),
          StatefulBuilder(
              builder: (context, state) {
                return Column(
                  children: [
                    ListTile(
                      title: Text('Is it safe to use this app?', style: GoogleFonts.montserrat(),),
                      trailing: Icon(pressed3?LineIcons.angleUp: LineIcons.angleDown),
                      onTap: (){
                        state((){
                          pressed3 = !pressed3;
                        });
                      },
                    ),
                    if(pressed3)
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text('We are only providing an easy User Interface to you. We do not take part in the payment process, it occurs through the gateway, That is why your hard earned money is safe with us. There could be no harm through our app.', style: GoogleFonts.montserrat(), textAlign: TextAlign.justify,),
                      ),
                    Divider()
                  ],
                );
              }
          )
        ],
      ),
    );
  }
}
