import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyupi/main.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneNumberEnteringScreen extends StatelessWidget {
  PhoneNumberEnteringScreen({Key? key}) : super(key: key);

  var upiIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Material(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: upiIdController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your UPI ID",
                  ),
                  keyboardType: TextInputType.text,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString("phoneNumber", upiIdController.text.toString());

                        FirebaseFirestore.instance
                            .collection("User Data")
                            .doc(upiIdController.text.toString())
                            .set({
                          'recipientName': FirebaseAuth.instance.currentUser!.displayName,
                          'phoneNumber': upiIdController.text.toString(),
                          'upiID': upiIdController.text.toString()
                        });

                        Get.off(FeatureDiscovery(child: MyHomePage()));
                      },
                      child: Text("Submit")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
