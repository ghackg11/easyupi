import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyupi/Screens/auth_screen.dart';
import 'package:easyupi/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

Drawer SideDrawer(){

  var value= 5.0;
  var feedbackTextController = TextEditingController();

  return Drawer(
    child: Container(
      color: darkBlack,
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!), fit: BoxFit.fitWidth),
            ), child: Container( color: Colors.black.withOpacity(0.6),child: Align(alignment: Alignment.bottomLeft ,child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(FirebaseAuth.instance.currentUser!.displayName!, style: GoogleFonts.montserrat(color: Colors.white, fontSize: 30),),
            ))),
          ),
          ListTile(
            title: Text('FAQ', style: GoogleFonts.montserrat(color: Colors.white),),
            leading: Icon(LineIcons.question, color: Colors.white,),
          ),
          Divider(color: grey,),
          ListTile(
            title: Text('Help', style: GoogleFonts.montserrat(color: Colors.white),),
            leading: Icon(LineIcons.helpingHands, color: Colors.white,),
          ),
          Divider(color: grey,),
          ListTile(
            title: Text('Feedback', style: GoogleFonts.montserrat(color: Colors.white),),
            leading: Icon(LineIcons.comment, color: Colors.white,),
            onTap: (){
              Get.dialog(
                AlertDialog(
                  title: Text('FeedBack'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('What do you think about our app?'),
                      ),
                      TextField(
                        controller: feedbackTextController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Feedback here"
                        ),
                      ),

                      StatefulBuilder(builder: (context, state){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RatingStars(
                            value: value,
                            onValueChanged: (v) {
                              //
                              state(() {
                                value = v;
                              });
                            },
                            starBuilder: (index, color) => Icon(
                              Icons.star,
                              color: color,
                            ),
                            starCount: 5,
                            starSize: 30,
                            valueLabelColor: const Color(0xff9b9b9b),
                            valueLabelTextStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0),
                            valueLabelRadius: 10,
                            maxValue: 5,
                            starSpacing: 2,
                            maxValueVisibility: true,
                            valueLabelVisibility: true,
                            animationDuration: Duration(milliseconds: 1000),
                            valueLabelPadding:
                            const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
                            valueLabelMargin: const EdgeInsets.only(right: 6),
                            starOffColor: const Color(0xffe7e8ea),
                            starColor: yellow,
                          ),
                        );
                      })

                    ],
                  ),
                  actions: [
                    TextButton(onPressed: (){
                      Get.back();
                    }, child: Text('Cancel')),
                    TextButton(onPressed: () async{
                      Get.back();
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      String phoneNumber = prefs.getString("phoneNumber")!;

                      await FirebaseFirestore.instance.collection("Feedbacks").doc(phoneNumber).set({
                        'feedbackText': feedbackTextController.text,
                        'rating': value
                      });

                      Get.snackbar("Success", "Feedback Submitted Succesfully");

                    }, child: Text('Submit')),
                  ],
                )
              );
            },
          ),
          Divider(color: grey,),
          ListTile(
            leading: Icon(LineIcons.alternateSignOut, color: Colors.white,),
            title: Text('Logout', style: GoogleFonts.montserrat(color: Colors.white),),
            onTap: (){
              FirebaseAuth.instance.signOut();
              Get.off(AuthScreen());
            },
          ),
          Divider(color: grey,),
        ],
      ),
    ),
  );
}