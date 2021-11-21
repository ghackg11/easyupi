import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:easyupi/Screens/amount_entering_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:collection';

import '../constants.dart';

Future<List<Contact>?> _getContacts() async {
  PermissionStatus permissionStatus = await _getContactPermission();
  List<Contact> docs, contacts = [];
  if (permissionStatus == PermissionStatus.granted) {
    docs = await ContactsService.getContacts(withThumbnails: false);

    HashMap hashMap = HashMap<String, String>(); // To store Duplicate numbers
    for (int i = 0; i < docs.length; i++) {
      String s1 = docs[i].phones![0].value.toString().replaceFirst("+91 ", '').removeAllWhitespace;
      s1 = s1.substring(s1.length - 10);
      docs[i].phones![0].value = s1;
      if (hashMap[s1] ?? true) {
        hashMap[s1] = '0';
      }
    }

    QuerySnapshot qs = await FirebaseFirestore.instance.collection("User Data").get();

    for (int i = 0; i < qs.docs.length; i++) {
      String s1 = hashMap[qs.docs[i]["phoneNumber"]] ?? "";
      if (s1 == "0") {
        hashMap[qs.docs[i]["phoneNumber"]] = qs.docs[i]["recipientName"];
      }
    }

    for (int i = 0; i < docs.length; i++) {
      if (hashMap[docs[i].phones![0].value!] != "0") {
        if (docs[i].displayName == null) {
          docs[i].displayName = hashMap[docs[i].phones![0].value!];
        }
        contacts.add(docs[i]);
      }
    }
  }

  return contacts;
}

Future<PermissionStatus> _getContactPermission() async {
  PermissionStatus permission = await Permission.contacts.status;
  if (permission != PermissionStatus.granted && permission != PermissionStatus.permanentlyDenied) {
    PermissionStatus permissionStatus = await Permission.contacts.request();
    return permissionStatus;
  } else {
    return permission;
  }
}

Row HomePageSection3() {
  return Row(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contacts',
              style: GoogleFonts.montserrat(color: grey),
            ),
            FutureBuilder(
              future: _getContacts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var docs = snapshot.data as List<Contact>;
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Get.to(AmountEnteringScreen(docs[index].phones![0].value.toString()));
                        },
                        title: Text(
                          '${docs[index].displayName}',
                          style: GoogleFonts.montserrat(color: Colors.white),
                        ),
                        leading: CircleAvatar(
                          child: Text(docs[index].displayName.toString()[0]),
                        ),
                      );
                    },
                  );
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Some Error Occured ${snapshot.error.toString()}'));
                }
                return Center(child: CircularProgressIndicator());
              },
            )
          ],
        ),
      )
    ],
  );
}
