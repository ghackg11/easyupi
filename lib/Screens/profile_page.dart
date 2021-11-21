import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: FutureBuilder(
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
                        QrImage(
                          data: (snapshot.data as DocumentSnapshot)['phoneNumber'],
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                        Text('UPI id: ${(snapshot.data as DocumentSnapshot)['phoneNumber']}')
                      ],
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        )
      ),
    );
  }
}
