import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easyupi/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyupi/Components/transaction_detail_list_item.dart';

Future<String> _getPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String phoneNumber = prefs.getString("phoneNumber")!;
  return phoneNumber;
}

class TransactionHistoryPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlack,
      body: SafeArea(
        child: FutureBuilder(
          future: _getPrefs(),
          builder: (context, prefs) {
            if (prefs.hasData) {
              String phoneNumber = prefs.data.toString();
              return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection("User Data")
                    .doc(phoneNumber)
                    .collection("Transaction History")
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    var docs = (snapshot.data as QuerySnapshot).docs;
                    List<TransactionDetailListItem> itemList = [];
                    for (int i = docs.length - 1; i >= 0; i--) {
                      itemList.insert(
                          docs.length - 1 - i,
                          TransactionDetailListItem(
                              recipientName: docs[i]["recipientName"],
                              phoneNumber: docs[i]["phoneNumber"],
                              transactionID: docs[i]["transactionID"],
                              dateTime: docs[i]["dateTime"],
                              transactionAmount: int.parse(docs[i]["transactionAmount"]),
                              applicationUsed: docs[i]["applicationUsed"]));
                    }
                    return ListView(
                      physics: BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      children: itemList,
                    );
                  }
                },
              );
            }
            if (prefs.hasError) {
              return Center(child: Text('Some Error Occurred ${prefs.error.toString()}'));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
