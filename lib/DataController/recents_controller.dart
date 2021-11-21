import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyupi/DataModel/person.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentsController extends GetxController{

  List<Person> recents = <Person>[].obs;

  @override
  void refresh() async{
    recents.clear();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phoneNumber = prefs.getString("phoneNumber")!;

    var historySnap = await FirebaseFirestore.instance.collection("User Data").doc(phoneNumber).collection("Transaction History").get();
    List<DocumentSnapshot> docs = historySnap.docs;

    for(DocumentSnapshot doc in docs){
      recents.add(Person(doc['phoneNumber'], doc['recipientName'],phoneNum: doc['phoneNumber']));
    }

    HashSet set = HashSet();
    for(Person p in recents){
      if(!set.contains(p)) {
        set.add(p);
      }
    }
    // Get.snackbar("test", "${set.length}");
    recents.clear();
    for(Person p in set){
      recents.add(p);
    }
  }

  @override
  void onInit() async{
    recents.clear();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phoneNumber = prefs.getString("phoneNumber")!;
    
    var historySnap = await FirebaseFirestore.instance.collection("User Data").doc(phoneNumber).collection("Transaction History").get();
    List<DocumentSnapshot> docs = historySnap.docs;

    for(DocumentSnapshot doc in docs){
      recents.add(Person(doc['phoneNumber'], doc['recipientName'],phoneNum: doc['phoneNumber']));
    }

    HashSet set = HashSet();
    for(Person p in recents){
      if(!set.contains(p)) {
        set.add(p);
      }
    }
    // Get.snackbar("test", "${set.length}");
    recents.clear();
    for(Person p in set){
      recents.add(p);
    }

  }
}