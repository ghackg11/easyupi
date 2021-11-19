import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyupi/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneNumberEnteringScreen extends StatelessWidget {
   PhoneNumberEnteringScreen({Key? key}) : super(key: key);

  var phoneController = TextEditingController();

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
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your UPI ID"
                  ),
                  keyboardType: TextInputType.phone,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(onPressed: (){

                    FirebaseFirestore.instance.collection("UserDetails").doc(FirebaseAuth.instance.currentUser!.uid).set({"phoneNumber": phoneController.text.toString()});
                    Get.off(MyHomePage());

                  }, child: Text("Submit")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
