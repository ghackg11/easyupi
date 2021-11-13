
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants.dart';

Future<List<Contact>?> _askPermissions() async {
  PermissionStatus permissionStatus = await _getContactPermission();
  if (permissionStatus == PermissionStatus.granted) {
    return ContactsService.getContacts(withThumbnails: false);
  }

  return null;
}

Future<PermissionStatus> _getContactPermission() async {
  PermissionStatus permission = await Permission.contacts.status;
  if (permission != PermissionStatus.granted &&
      permission != PermissionStatus.permanentlyDenied) {
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
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contacts',
              style: GoogleFonts.montserrat(color: grey),
            ),
            FutureBuilder(
              future: _askPermissions(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  var docs = snapshot.data as List<Contact>;
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: docs.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        onTap: (){

                        },
                        title: Text('${docs[index].displayName}', style: GoogleFonts.montserrat(color: Colors.white),),
                        leading: CircleAvatar(
                          child: Text(docs[index].displayName.toString()[0]),
                        ),
                      );
                    },
                  );
                }
                if(snapshot.hasError){
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
