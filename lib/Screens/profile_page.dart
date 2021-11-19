import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection("UserDetails").doc(FirebaseAuth.instance.currentUser!.uid).get(),
          builder: (context, snapshot){
            if(snapshot.connectionState==ConnectionState.done){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  QrImage(
                    data: (snapshot.data as DocumentSnapshot)['upiId'],
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  Text('UPI id: ${(snapshot.data as DocumentSnapshot)['upiId']}')
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        )
      ),
    );
  }
}
