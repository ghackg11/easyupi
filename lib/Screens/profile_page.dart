import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyupi/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlack,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(12),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: grey,
                ),
                child: FutureBuilder(
                  future: SharedPreferences.getInstance(),
                  builder: (context, snapshot){
                    if(snapshot.hasData) {
                      String phoneNumber = (snapshot.data as SharedPreferences).get("phoneNumber")!.toString();
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(FirebaseAuth.instance.currentUser!.displayName!, style: GoogleFonts.montserrat(color: Colors.white, fontSize: 25),),
                                  Text(phoneNumber, style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );


                    }else{
                      return LinearProgressIndicator();
                    }
                  },
                )
              ),
              QRCode(),
            ],
          )
        ),
      ),
      appBar: AppBar(
        title: Text('My Profile'),
      ),
    );
  }

  FutureBuilder<SharedPreferences> QRCode() {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            String phoneNumber = (snapshot.data as SharedPreferences).get("phoneNumber")!.toString();
            return FutureBuilder(
              future: FirebaseFirestore.instance.collection("User Data").doc(phoneNumber).get(),
              builder: (context, snapshot){
                if(snapshot.connectionState==ConnectionState.done){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 12, right: 12, bottom: 30, top: 12),
                        decoration: BoxDecoration(
                          color: grey,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white
                              ),
                              child: QrImage(
                                data: (snapshot.data as DocumentSnapshot)['phoneNumber'],
                                version: QrVersions.auto,
                                size: 200.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text('Share this QR code to recieve payment', style: GoogleFonts.montserrat(color: yellow, fontSize: 16), textAlign: TextAlign.center,),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      );
  }
}
